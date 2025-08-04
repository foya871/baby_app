/*
 * @Author: wangdazhuang
 * @Date: 2024-08-28 19:50:08
 * @LastEditTime: 2025-07-05 14:54:21
 * @LastEditors: wdz
 * @Description: 
 * @FilePath: /baby_app/lib/views/player/views/comment_list.dart
 */

import 'package:baby_app/components/ad/ad_enum.dart';
import 'package:baby_app/components/ad/ad_utils.dart';
import 'package:baby_app/utils/enum.dart';
import 'package:baby_app/utils/extension.dart';
import 'package:collection/collection.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:baby_app/assets/styles.dart';
import 'package:baby_app/components/app_bg_view.dart';
import 'package:baby_app/components/diolog/dialog.dart';
import 'package:baby_app/components/diolog/loading/loading_view.dart';
import 'package:baby_app/components/no_more/no_data.dart';
import 'package:baby_app/generate/app_image_path.dart';
import 'package:baby_app/routes/routes.dart';
import 'package:baby_app/utils/color.dart';
import 'package:http_service/http_service.dart';
import 'package:short_video_mudle/short_video_mudle.dart';
import 'package:baby_app/views/player/views/comment_cell.dart';

import '../../../http/api/api.dart';
import '../../../model/comment/comment_model.dart';

class PlayCommentList extends StatefulWidget {
  final int videoId;

  const PlayCommentList({super.key, required this.videoId});

  @override
  State<StatefulWidget> createState() {
    return PlayerCommentsState();
  }
}

class PlayerCommentsState extends SafeState<PlayCommentList> {
  int _page = 1;

  int get videoId => widget.videoId;

  final _pageSize = 100;
  List<CommentModel> _dataList = [];

  final refreshController = EasyRefreshController();
  CommentModel? selectedItem;
  CommentModel? topModel;
  final controller = TextEditingController();
  final node = FocusNode();

  void _refreshUI() => setState(() {});

  /// 刷新
  Future<IndicatorResult> onRefreshComments() async {
    _page = 1;
    var results = await Api.getVideoComment(
        videoId: videoId, page: _page, pageSize: _pageSize);
    final ads = AdUtils().getAdLoadInOrder(AdApiType.COMMENT_TEXT);

    if (results == null || results.isEmpty == true) {
      results = [];
      if (ads.isNotEmpty) {
        final models = ads.map((e) => CommentModel.fromAd(e)).toList();
        results.addAll(models);
      }
    } else {
      ///
      if (ads.isNotEmpty) {
        final models = ads.map((e) => CommentModel.fromAd(e)).toList();
        models.mapIndexed((index, e) {
          results!.insert(index, e);
        });
      }
    }
    _dataList = results;
    _refreshUI();
    if (results.isEmpty == true) return IndicatorResult.fail;
    return IndicatorResult.success;
  }

  // 上拉加载更多
  Future<IndicatorResult> onLoadComments() async {
    _page = _page + 1;
    var results = await Api.getVideoComment(
        videoId: videoId, page: _page, pageSize: _pageSize);
    if (results?.isEmpty == true) {
      return IndicatorResult.noMore;
    }
    _dataList.addAll(results!);
    return IndicatorResult.success;
  }

  // 添加评论
  addComments(String content) async {
    await LoadingView.singleton.wrap(
        context: Get.context!,
        asyncFunction: () async {
          try {
            final s = await httpInstance.post(
                url: 'video/saveComment',
                body: {
                  "videoId": widget.videoId,
                  "content": content,
                  "topId": topModel?.commentId ?? 0,
                  "parentId": selectedItem?.commentId ?? 0,
                },
                complete: CommentModel.fromJson);
            showToast("评论成功,请等待审核!");
            if (s is CommentModel == false) {
              reset();
              return null;
            }
            if (topModel != null && selectedItem != null) {
              CommentModel some = _dataList
                  .firstWhere((e) => e.commentId == topModel!.commentId);
              some.replyNum += 1;
              some.replyItems?.add(s);
            } else {
              if (_dataList.isEmpty) {
                _dataList.add(s);
              } else {
                _dataList.insert(0, s);
              }
            }
            reset();
            return s;
          } catch (_) {
            reset();
            final resp = ApiErrorWrap.wrap(_);
            if (resp.code == 1029) {
              showToOpenVipDialog(
                Get.context!,
                message: '你还不是会员\n${resp.msg ?? ''}',
                onRightButton: () => Get.toVip(),
              );
            }
            return null;
          }
        });
  }

  void reset() {
    selectedItem = null;
    topModel = null;
    controller.text = "";
    node.unfocus();
    if (mounted) {
      setState(() {});
    }
  }

  Future likeCommentAction(CommentModel m) async {
    //长短视频
    final r = await Api.likeVideoComment(
        toLike: !m.isLike.value, commentId: m.commentId);
    if (r) {
      m.isLike.value = !m.isLike.value;
      if (m.isLike.value) {
        m.fakeLikes = m.fakeLikes + 1;
      } else {
        m.fakeLikes = m.fakeLikes - 1;
      }
      if (mounted) {
        setState(() {});
      }
    }
  }

  _buildCommentList() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.w),
      sliver: _dataList.isEmpty
          ? SizedBox(
              width: Get.width,
              height: 250.w,
              child: const Center(child: NoData()),
            ).sliver
          : SliverList.builder(
              itemCount: _dataList.length,
              itemBuilder: (context, index) {
                return CommentCell(
                  videoId: widget.videoId,
                  model: _dataList[index],
                  tap: (v) {
                    /// 回复
                    selectedItem = v;
                    topModel = v;
                    node.requestFocus();
                    if (mounted) {
                      setState(() {});
                    }
                  },
                  tapList: (m, m1) {
                    //m是顶层 m1是parent
                    selectedItem = m1;
                    topModel = m;
                    if (mounted) {
                      setState(() {});
                    }
                  },
                  likeLelvel1: (m) {
                    likeCommentAction(m);
                  },
                  likeLevel2: (m, m1) {
                    likeCommentAction(m1);
                  },
                );
              },
            ),
    );
  }

  @override
  void initState() {
    super.initState();
    onRefreshComments();
    node.addListener(
      () {},
    );
  }

  ///添加评论
  void sendAction() {
    if (controller.text.isEmpty) {
      node.unfocus();
      selectedItem = null;
      topModel = null;
      controller.text = "";
      setState(() {});
      return;
    }
    addComments(controller.text);
  }

  _buildBottomBox() {
    return Row(
      children: [
        Expanded(
          child: Container(
              height: 35.w,
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20.w)),
              child: SizedBox(
                height: 44.w,
                width: double.infinity,
                child: TextField(
                  cursorHeight: 20.w,
                  focusNode: node,
                  controller: controller,
                  textAlignVertical: TextAlignVertical.center,
                  textInputAction: TextInputAction.done,
                  onEditingComplete: () {
                    node.unfocus();
                    sendAction();
                  },
                  style: kTextStyle(Colors.white),
                  cursorColor: COLOR.color_999999,
                  decoration: InputDecoration(
                    hintText: selectedItem == null
                        ? "写下你的评论..."
                        : '回复@${selectedItem!.nickName}',
                    hintStyle: kTextStyle(COLOR.color_999999, fontsize: 14.w),
                    focusedBorder: InputBorder.none,
                    contentPadding: EdgeInsets.only(bottom: 10.w),
                    border: InputBorder.none,
                    labelStyle: kTextStyle(Colors.white, fontsize: 15.w),
                  ),
                ),
              ).marginHorizontal(4.w)),
        ),
        Container(
          width: 40.w,
          height: 30.w,
          alignment: Alignment.center,
          child: Image.asset(
            AppImagePath.player_send,
            width: 30.w,
            height: 30.w,
          ),
        ).onTap(() {
          node.unfocus();
          sendAction();
        }),
      ],
    ).basePaddingHorizontal;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: EasyRefresh.builder(
            onRefresh: onRefreshComments,
            onLoad: onLoadComments,
            controller: refreshController,
            childBuilder: (context, physics) => CustomScrollView(
              physics: physics,
              slivers: <Widget>[
                _buildCommentList(),
              ],
            ),
          ),
        ),
        _buildBottomBox(),
        20.verticalSpace,
      ],
    );
  }
}
