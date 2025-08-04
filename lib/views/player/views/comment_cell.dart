import 'package:http_service/http_service.dart';
import 'package:short_video_mudle/short_video_mudle.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../assets/styles.dart';
import '../../../components/easy_button.dart';
import '../../../components/image_view.dart';
import '../../../components/text_view.dart';
import '../../../generate/app_image_path.dart';
import '../../../model/comment/comment_model.dart';
import '../../../utils/ad_jump.dart';
import '../../../utils/app_utils.dart';
import '../../../utils/color.dart';
import '../../../utils/utils.dart';
import 'comment_sub_cell.dart';

class CommentCell extends StatefulWidget {
  final CommentModel model;
  final void Function(CommentModel) tap;
  final void Function(CommentModel, CommentModel) tapList;
  final void Function(CommentModel) likeLelvel1;
  final void Function(CommentModel, CommentModel) likeLevel2;
  final int videoId;

  const CommentCell({
    super.key,
    required this.model,
    required this.videoId,
    required this.tap,
    required this.tapList,
    required this.likeLelvel1,
    required this.likeLevel2,
  });

  @override
  State<StatefulWidget> createState() {
    return CommentCellState();
  }
}

class CommentCellState extends State<CommentCell> {
  CommentModel get model => widget.model;

  String get logo => model.isAd ? model.ad?.adImage ?? '' : model.logo;
  String get name => model.isAd ? model.ad?.adName ?? '' : model.nickName;
  String get content =>
      model.isAd ? model.ad?.adDescription ?? '' : model.content;
  String get time => Utils.dateAgo(model.createdAt);
  bool get isCommon => !model.isAd && !model.officialComment;

  Widget _buildLogo() => ImageView(
      height: 36.w,
      width: 36.w,
      src: logo,
      borderRadius: BorderRadius.circular(18.w));

  /// 获取二级回复
  Future getSecondCommentList() async {
    try {
      final params = {"videoId": widget.videoId};
      final s = await httpInstance.get(
        url: 'video/commentList',
        queryMap: {
          ...params,
          "page": 1,
          "pageSize": 100,
          "parentId": _model.commentId,
        },
        complete: CommentModel.fromJson,
      );
      if (s is List<CommentModel> == false) return;
      _model.replyItems = s;
      if (mounted) {
        setState(() {});
      }
    } catch (_) {}
  }

  CommentModel get _model => widget.model;

  Color get txtColor => isCommon ? Colors.white : COLOR.themeSelectedColor;

  Widget _buildNameAndVipLogo() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(name, style: kTextStyle(txtColor, fontsize: 12.w)),
        3.horizontalSpace,
        if (_model.vipType > 0 && isCommon)
          Image.asset(AppUtils.getVipTypeToImagePath(_model.vipType),
              height: 20.w),
      ],
    );
  }

  Widget _buildReplyAndTime() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        EasyButton.child(
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_model.replyItems?.isNotEmpty == true)
                TextView(
                  text: '${_model.replyItems?.length ?? 0}',
                  fontSize: 12.w,
                  color: Colors.white.withValues(alpha: 0.6),
                ),
              if (_model.replyItems?.isNotEmpty == true) 1.horizontalSpace,
              TextView(
                text: '回复',
                fontSize: 12.w,
                color: Colors.white.withValues(alpha: 0.6),
              ),
              1.horizontalSpace,
              Image.asset(AppImagePath.player_more_arrow,
                  width: 12.w, height: 12.w),
            ],
          ),
          height: 26.w,
          minWidth: 55.w,
          borderRadius: BorderRadius.circular(13.w),
          borderColor: Colors.white.withValues(alpha: 0.1),
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          backgroundColor: Colors.white.withValues(alpha: 0.1),
        ),
      ],
    );
  }

  ///内容
  Widget _buildContent() =>
      TextView(text: content, color: txtColor, fontSize: 13.w);

  Widget _buildExpand() {
    return _model.replyNum == 0
        ? const SizedBox()
        : (_model.replyItems?.isEmpty ?? true)
            ? Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  20.horizontalSpace,
                  Text("展开全部回复",
                          style: kTextStyle(COLOR.themeSelectedColor,
                              fontsize: 12.w))
                      .marginLeft(8.w),
                  Icon(
                    Icons.expand_more,
                    size: 20.w,
                    color: COLOR.themeSelectedColor,
                  ),
                ],
              ).marginOnly(top: 14.w).onOpaqueTap(() {
                getSecondCommentList();
              })
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _model.replyItems!
                    .map((e) => CommentSubCell(
                          model: e,
                          tap: (subItem) {
                            widget.tapList(_model, subItem);
                          },
                          likeTap: (e) {
                            widget.likeLevel2(_model, e);
                          },
                        ))
                    .toList(),
              ).marginTop(14.w);
  }

  _buildRight() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildNameAndVipLogo(),
          5.verticalSpace,
          _buildContent(),
          6.verticalSpace,
          if (isCommon) _buildReplyAndTime(),
          if (isCommon) _buildExpand(),
        ],
      ),
    );
  }

  void _tapAction() {
    if (model.isAd) {
      final ad = model.ad;
      if (ad != null) {
        kAdjump(ad);
      }
      return;
    }
    if (model.officialComment) {
      final url = model.jumpUrl;
      jumpExternalURL(url);
      return;
    }
    widget.tap(widget.model);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLogo(),
        8.horizontalSpace,
        _buildRight(),
        8.horizontalSpace,
      ],
    ).onOpaqueTap(_tapAction).paddingBottom(15.w);
  }
}
