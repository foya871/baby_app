import 'package:baby_app/components/diolog/loading/loading_view.dart';
import 'package:baby_app/components/easy_toast.dart';
import 'package:baby_app/components/keep_alive_wrapper.dart';
import 'package:baby_app/components/no_more/no_data.dart';
import 'package:baby_app/components/no_more/no_more.dart';
import 'package:baby_app/generate/app_image_path.dart';
import 'package:baby_app/http/api/api.dart';
import 'package:baby_app/model/comment/comment_dynamic_model.dart';
import 'package:baby_app/model/comment/comment_send_model.dart';
import 'package:baby_app/utils/color.dart';
import 'package:short_video_mudle/short_video_mudle.dart';
import 'package:baby_app/views/community/comment/comment_cell.dart';
import 'package:baby_app/views/community/widget/debounce_click.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:short_video_mudle/short_video_mudle.dart';

class CommentPage extends StatefulWidget {
  const CommentPage({
    super.key,
    required this.dynamicId,
    required this.parentId,
    required this.nickName,
  });

  final int dynamicId;
  final int parentId;
  final String nickName;

  @override
  State createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  final _pageSize = 40;
  final PagingController<int, CommentDynamicModel> _pagingController =
      PagingController(firstPageKey: 1);

  TextEditingController commTextController = TextEditingController();
  FocusNode focusNode = FocusNode();
  ValueNotifier<bool> showComm = ValueNotifier(false);
  ValueNotifier<String> defaultText = ValueNotifier('回复');
  var params = CommentSendModel.fromJson({});

  final debounceClick = DebounceClick(milliseconds: 1000);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _initListData(pageKey);
    });
    super.initState();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        showComm.value = true;
      } else {
        showComm.value = false;
      }
    });
    defaultText.value = '回复 ${widget.nickName}：';
  }

  @override
  void dispose() {
    focusNode.dispose();
    commTextController.dispose();
    super.dispose();
  }

  Future _initListData(int pageKey) async {
    List<CommentDynamicModel>? result = await Api.getCommentList(
      dynamicId: widget.dynamicId,
      parentId: widget.parentId,
      page: pageKey,
      pageSize: _pageSize,
    );

    result ??= [];
    final isLastPage = result.length < _pageSize;
    if (isLastPage) {
      _pagingController.appendLastPage(result);
    } else {
      final nextPageKey = pageKey + 1;
      _pagingController.appendPage(result, nextPageKey as int?);
    }
  }

  Future addReply(int dynamicId, int parentId, int topId) async {
    if (commTextController.text.isEmpty) {
      EasyToast.show('评论内容不能为空');
      return;
    }

    params.dynamicId = dynamicId;
    params.parentId = parentId;
    params.topId = topId;
    params.content = commTextController.text;

    debounceClick.run(() async {
      final result = await LoadingView.singleton.wrap(
        context: Get.context!,
        asyncFunction: () async {
          return await Api.communitySaveComment(model: params);
        },
      );

      if (result) {
        params = CommentSendModel.fromJson({
          'parentId': 0,
          'topId': 0,
        });
        EasyToast.show('评论成功,请等待审核!');
      }
      params.img = null;
      commTextController.text = '';
      focusNode.unfocus();
    });
  }

  _buildInput() {
    return ValueListenableBuilder(
      valueListenable: showComm,
      builder: (context, value, child) {
        return Container(
          padding: EdgeInsets.only(left: 14.w, right: 14.w, bottom: 9.w),
          color: COLOR.transparent,
          child: Row(
            children: <Widget>[
              Visibility(
                visible: !value,
                maintainState: true,
                child: Container(
                  width: 332.w,
                  height: 36.w,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      color: COLOR.white_10,
                      borderRadius: BorderRadius.circular(18.w)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        defaultText.value,
                        style: TextStyle(
                          color: COLOR.white_60,
                          fontSize: 13.w,
                        ),
                      ).marginOnly(left: 15.w),
                    ],
                  ),
                ).onOpaqueTap(() {
                  focusNode.requestFocus();
                }),
              ),
              Visibility(
                visible: value,
                maintainState: true,
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 280.w,
                      height: 70.w,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        color: COLOR.white_10,
                        borderRadius: BorderRadius.circular(18.w),
                      ),
                      child: ValueListenableBuilder(
                          valueListenable: defaultText,
                          builder: (context, value, child) {
                            return TextField(
                              focusNode: focusNode,
                              maxLines: 5,
                              style: TextStyle(
                                color: COLOR.white,
                                fontSize: 13.w,
                              ),
                              controller: commTextController,
                              onSubmitted: (value) {
                                addReply(widget.dynamicId, widget.parentId,
                                    widget.parentId);
                              },
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10.w),
                                  hintText: value,
                                  hintStyle: TextStyle(
                                    color: COLOR.color_9B9B9B,
                                    fontSize: 13.w,
                                  ),
                                  enabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromRGBO(0, 0, 0, 0))),
                                  focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromRGBO(0, 0, 0, 0)))),
                            );
                          }),
                    ),
                    Container(
                      width: 56.w,
                      height: 32.w,
                      alignment: Alignment.bottomCenter,
                      decoration: BoxDecoration(
                        color: COLOR.color_009fe8,
                        borderRadius: BorderRadius.circular(16.w),
                      ),
                      child: Center(
                        child: Text(
                          '发布',
                          style: TextStyle(
                            color: COLOR.white,
                            fontSize: 14.w,
                          ),
                        ),
                      ).onOpaqueTap(() {
                        addReply(
                            widget.dynamicId, widget.parentId, widget.parentId);
                      }),
                    ).marginOnly(left: 10.w),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15.w),
              child: SizedBox(width: 15.w),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  '全部评论',
                  style: TextStyle(
                    color: COLOR.white,
                    fontSize: 18.w,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15.w),
              child: Image.asset(
                AppImagePath.community_close,
                width: 18.w,
                height: 18.w,
              ),
            ).onOpaqueTap(() {
              Navigator.pop(context);
            }),
          ],
        ),
        Expanded(
          child: KeepAliveWrapper(
            child: RefreshIndicator(
              onRefresh: () => Future.sync(
                () => _pagingController.refresh(),
              ),
              child: PagedListView<int, CommentDynamicModel>(
                padding: EdgeInsets.only(top: 0.w),
                addAutomaticKeepAlives: true,
                pagingController: _pagingController,
                builderDelegate: PagedChildBuilderDelegate<CommentDynamicModel>(
                  noMoreItemsIndicatorBuilder: (context) => const NoMore(),
                  noItemsFoundIndicatorBuilder: (context) => const NoData(),
                  itemBuilder: (context, item, index) {
                    return CommentCell(
                      model: item,
                      nickName: widget.nickName ?? '',
                    );
                  },
                ),
              ),
            ),
          ),
        ),
        _buildInput(),
      ],
    ).onOpaqueTap(() {
      FocusManager.instance.primaryFocus?.unfocus();
    });
  }
}
