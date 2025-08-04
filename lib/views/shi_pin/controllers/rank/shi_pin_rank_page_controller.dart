/*
 * @Author: wangdazhuang
 * @Date: 2025-02-22 15:24:34
 * @LastEditTime: 2025-02-26 17:15:22
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /baby_app/lib/views/shi_pin/controllers/rank/shi_pin_rank_page_controller.dart
 */
import 'package:get/get.dart';

import '../../../../components/base_refresh/base_refresh_simple_controller.dart';
import '../../../../http/api/api.dart';
import '../../../../model/classify/classify_models.dart';
import '../../../../model/video_base_model.dart';
import '../../../../utils/enum.dart';
import '../../../../utils/utils.dart';

const _pageSize = 100;
const _useObs = true;

class ShiPinRankPageController
    extends BaseRefreshSimpleController<VideoBaseModelWithIndex> {
  late final ClassifyModel classify;
  late final ShiPinRankType rankType;
  late final String pageTitle;
  @override
  bool get useObs => _useObs;

  @override
  Future<List<VideoBaseModelWithIndex>?> dataFetcher(int page,
      {required bool isRefresh}) async {
    final vidoes = await Api.fetchVideoRankByClassify(
      classifyId: classify.classifyId,
      page: page,
      pageSize: _pageSize,
      type: rankType,
    );
    if (vidoes == null) return null;
    return VideoBaseModelWithIndex.fromList(vidoes, offset: data.length);
  }

  @override
  bool noMoreChecker(List resp) => resp.length < _pageSize;

  @override
  void onInit() {
    classify = Utils.asType<ClassifyModel>(Get.arguments['classify'])!;
    rankType = Utils.asType<ShiPinRankType>(Get.arguments['rankType'])!;
    pageTitle = Utils.asType<String>(Get.arguments['title'])!;

    super.onInit();
  }
}
