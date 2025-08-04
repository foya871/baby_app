import 'package:get/get.dart';

import '../../../http/api/api.dart';
import '../../../model/station_model.dart';
import '../../../model/video_base_model.dart';
import '../../../routes/routes.dart';
import '../../../utils/consts.dart';
import '../../base_refresh/simple_data_keeper.dart';

class StationBaseCellController extends GetxController {
  bool _inited = false;
  late final StationModel station;
  bool _noMore = false;
  int _indexOffset = 0;
  final dataKeeper = SimpleDataKeeper<VideoBaseModelWithIndex>(true);

  void init(StationModel station) {
    if (_inited) return;
    this.station = station;
    dataKeeper.addData(
      VideoBaseModelWithIndex.fromList(station.videoList, offset: _indexOffset),
    );
    _indexOffset = station.videoList.length;
    dataKeeper.resetPage(Consts.pageFirst + 1);
    _inited = true;
  }

  // 换一换
  Future onTapChange() async {
    if (_noMore) return;
    List<VideoBaseModel>? resp;
    final page = dataKeeper.page;
    final pageSize = station.pageSize;
    if (station.isRank) {
      resp = await Api.fetchVideosByRanking(
        type: station.type,
        page: page,
        pageSize: pageSize,
      );
    } else {
      resp = [];
      // resp = await Api.fetchVideosByStationId(
      //   stationId: station.stationId,
      //   page: page,
      //   pageSize: pageSize,
      // );
    }
    if (resp == null) return;

    _noMore = resp.length < pageSize;

    if (resp.isEmpty) {
      // 最后一页没数据，不刷新
      return;
    }
    // 这里使用set
    dataKeeper.setData(
      VideoBaseModelWithIndex.fromList(resp, offset: _indexOffset),
    );
    _indexOffset += resp.length;

    dataKeeper.incPage();
  }

  // 更多影片
  void onTapMore() => Get.toStationDetail(station);
}
