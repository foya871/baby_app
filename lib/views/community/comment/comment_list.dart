import 'package:baby_app/components/no_more/no_data.dart';
import 'package:baby_app/components/no_more/no_more.dart';
import 'package:baby_app/http/api/api.dart';
import 'package:baby_app/model/comment/comment_dynamic_model.dart';
import 'package:baby_app/model/comment/comment_send_model.dart';
import 'package:baby_app/views/community/comment/comment_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class CommentList extends StatefulWidget {
  const CommentList({
    super.key,
    required this.dynamicId,
    this.parentId,
    required this.reply,
  });

  final int dynamicId;
  final int? parentId;
  final Function reply;

  @override
  State<StatefulWidget> createState() => _CommentList();
}

class _CommentList extends State<CommentList> {
  final _pageSize = 40;
  final PagingController<int, CommentDynamicModel> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _initListData(pageKey);
    });
    super.initState();
  }

  @override
  void didUpdateWidget(CommentList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.dynamicId != widget.dynamicId) {
      _pagingController.refresh();
    }
  }

  Future _initListData(int pageKey) async {
    List<CommentDynamicModel>? result = await Api.getCommentList(
      dynamicId: widget.dynamicId,
      parentId: widget.parentId ?? 0,
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

  @override
  Widget build(BuildContext context) {
    return PagedSliverList(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<CommentDynamicModel>(
            noMoreItemsIndicatorBuilder: (_) {
          return const NoMore();
        }, noItemsFoundIndicatorBuilder: (_) {
          return const NoData();
        }, itemBuilder: (context, value, index) {
          return CommentItem(
            comment: value,
            dynamicId: widget.dynamicId,
            reply: (CommentSendModel v, String nick) {
              widget.reply(v, nick);
            },
          ).marginOnly(bottom: 10.w);
        }));
  }
}
