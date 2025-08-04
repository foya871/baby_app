import 'package:get/get.dart';
import 'package:tuple/tuple.dart';

import '../../../../components/base_refresh/base_refresh_data_keeper.dart';
import '../../../../components/base_refresh/base_refresh_tab_controller.dart';
import '../../../../components/base_refresh/base_refresh_tab_key.dart';
import '../../../../http/api/api.dart';
import '../../../../model/blogger/blogger_video_collection.dart';
import '../../../../model/video_base_model.dart';
import '../../../../utils/enum.dart';
import '../../../../utils/utils.dart';

const _pageSize = 60;
const _useObs = true;

class _DataKeeper
    extends BaseRefreshDataKeeperWithERController<VideoBaseModel> {
  final int collectionId;
  final int sortType;

  _DataKeeper({
    required this.sortType,
    required this.collectionId,
  });

  @override
  bool get useObs => _useObs;

  @override
  Future<List<VideoBaseModel>?> dataFetcher(int page,
      {required bool isRefresh}) {
    return Future.value([]);
    // return Api.fetchVideosByCollectionId(
    //   page: page,
    //   pageSize: _pageSize,
    //   sortType: sortType,
    //   collectionId: collectionId,
    // );
  }

  @override
  bool noMoreChecker(List<VideoBaseModel> resp) => resp.length < _pageSize;
}

class BloggerCollectionDetailPageController
    extends BaseRefreshDefaultTabController {
  static const sortTabs = [
    Tuple2('最新更新', VideoSortTypeEnum.latest),
    Tuple2('最多观看', VideoSortTypeEnum.mostPlayed),
    Tuple2('最多购买', VideoSortTypeEnum.mostFav),
  ];

  static int getSortTypeByIndex(int index) => sortTabs[index].item2;

  late final int collectionId;
  var detail = CollectionDetailModel.empty().obs;

  Future toogleFavorite() async {
    if (detail.value.isEmpty) return;
    final old = detail.value.favorite;
    final ok = await Api.toogleBloggerCollectionFavorite(
      collectionId,
      favorite: old,
    );
    if (ok) {
      detail.update((v) {
        v?.favorite = !old;
      });
    }
  }

  @override
  bool get useObs => _useObs;

  @override
  BaseRefreshDataKeeperWithERController initDataKeeper(
      BaseRefreshTabKey tabKey) {
    final key = tabKey as BaseRefreshTabIndexKey;
    return _DataKeeper(
      sortType: getSortTypeByIndex(key.index),
      collectionId: collectionId,
    );
  }

  void _fetchDetail() async {
    final resp = await Api.fetchBloggerCollectionDetail(collectionId);
    if (resp != null) {
      detail.value = resp;
    }
  }

  @override
  void onInit() {
    collectionId = Utils.asType<int>(Get.arguments['collectionId'])!;
    _fetchDetail();
    super.onInit();
  }
}
