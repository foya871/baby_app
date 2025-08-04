import 'package:get/get.dart';

import '../../../../http/api/api.dart';
import '../../../../model/station_model.dart';
import '../../../../model/video_base_model.dart';
import '../../../../utils/enum.dart';
import '../../../../utils/utils.dart';
import '../station_choice_detail_base_page_controller.dart';

class StationDetailWithSortingPageController
    extends StationChoiceDetailBasePageController {
  late final StationModel station;
  @override
  String get title => station.stationName;

  @override
  String get info => station.info;

  @override
  String get coverImg => station.coverImg;

  @override
  bool get isVerticalLayout =>
      station.detailStyle == StationDetailStyle.vertical;

  @override
  Future<List<VideoBaseModel>?> Function(int page, int pageSize) dataFetcherApi(
      VideoSortType sortType) {
    // return (int page, int pageSize) => Api.fetchVideosByStationId(
    //       stationId: station.stationId,
    //       page: page,
    //       pageSize: pageSize,
    //       sortType: sortType,
    //     );
    return (int page, int pageSize) => Future.value([]);
  }

  @override
  void onInit() {
    station = Utils.asType<StationModel>(Get.arguments?['station'])!;
    super.onInit();
  }
}
