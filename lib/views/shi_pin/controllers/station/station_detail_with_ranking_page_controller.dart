import '../../../../components/base_refresh/base_refresh_simple_controller.dart';
import '../../../../http/api/api.dart';
import '../../../../model/station_model.dart';
import '../../../../model/video_base_model.dart';
import '../../../../utils/utils.dart';
import 'package:get/get.dart';

const _useObs = true;
const _pageSize = 60;

class StationDetailWithRankdingPageController
    extends BaseRefreshSimpleController<VideoBaseModelWithIndex> {
  late final StationModel station;

  @override
  bool get useObs => _useObs;

  @override
  Future<List<VideoBaseModelWithIndex>?> dataFetcher(int page,
      {required bool isRefresh}) async {
    final resp = await Api.fetchVideosByRanking(
      page: page,
      pageSize: _pageSize,
      type: station.type, // 这里type 目前是和station一致的
    );
    if (resp == null) return null;
    return VideoBaseModelWithIndex.fromList(resp);
  }

  @override
  bool noMoreChecker(List resp) => resp.length < _pageSize;

  @override
  void onInit() {
    station = Utils.asType<StationModel>(Get.arguments['station'])!;
    super.onInit();
  }
}
