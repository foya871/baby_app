import 'package:baby_app/components/keep_alive_wrapper.dart';
import 'package:baby_app/components/no_more/no_data.dart';
import 'package:baby_app/components/no_more/no_more.dart';
import 'package:baby_app/http/api/api.dart';
import 'package:baby_app/model/community/community_model.dart';
import 'package:baby_app/views/community/list/community_cell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class CommunityListPage extends StatefulWidget {
  const CommunityListPage({
    super.key,
    required this.dataType,
    this.loadType,
    this.classify,
    this.topicId,
    this.userId,
  });

  final int dataType;
  final int? loadType;
  final String? classify;
  final String? topicId;
  final int? userId;

  @override
  State createState() => _CommunityListPageState();
}

class _CommunityListPageState extends State<CommunityListPage> {
  final _pageSize = 40;
  final PagingController<int, CommunityModel> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _initListData(pageKey);
    });
    super.initState();
  }

  Future _initListData(int pageKey) async {
    List<CommunityModel>? result = [];
    if (widget.dataType == 0 ||
        widget.dataType == 1 ||
        widget.dataType == 2 ||
        widget.dataType == 3 ||
        widget.dataType == 4) {
      result = await Api.getDynamicList(
        classify: widget.classify ?? '',
        loadType: widget.loadType ?? 0,
        page: pageKey,
        pageSize: _pageSize,
      );
    } else if (widget.dataType == 5 ||
        widget.dataType == 6 ||
        widget.dataType == 7 ||
        widget.dataType == 8 ||
        widget.dataType == 9) {
      result = await Api.getTopicDynamicList(
        topicId: widget.topicId ?? '',
        loadType: widget.loadType ?? 0,
        page: pageKey,
        pageSize: _pageSize,
      );
    } else if (widget.dataType == 10) {
      result = await Api.getUserDynamicList(
        userId: widget.userId ?? 0,
        page: pageKey,
        pageSize: _pageSize,
      );
    }

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
    return KeepAliveWrapper(
      child: RefreshIndicator(
        onRefresh: () => Future.sync(
          () => _pagingController.refresh(),
        ),
        child: PagedListView<int, CommunityModel>(
          padding: EdgeInsets.only(top: 0.w),
          addAutomaticKeepAlives: true,
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<CommunityModel>(
            noMoreItemsIndicatorBuilder: (context) => const NoMore(),
            noItemsFoundIndicatorBuilder: (context) => const NoData(),
            itemBuilder: (context, item, index) {
              return CommunityCell(model: item);
            },
          ),
        ),
      ),
    );
  }
}
