part of 'api.dart';

// ignore: library_private_types_in_public_api
extension ApiAi on _Api {
  // 维护
  Future<AiEntranceConfigModel?> fetchAiEntranceConfig() async {
    try {
      final resp = await httpInstance.get(
        url: 'aibox/entranceConfig',
        complete: AiEntranceConfigModel.fromJson,
      );
      return resp;
    } catch (e) {
      return null;
    }
  }

  // 去衣-下单
  Future<BaseRespModel> createAiClothOffBoxOrder(Uint8List file) =>
      _createAiBoxOrder(type: 1, file: file, stencilId: null);
  // 图片换脸
  Future<BaseRespModel> createAiFaceImageOrder(
          String stencilId, Uint8List file) =>
      _createAiBoxOrder(type: 2, file: file, stencilId: stencilId);
  // 视频换脸
  Future<BaseRespModel> createAiFaceVideoOrder(
          String stencilId, Uint8List file) =>
      _createAiBoxOrder(type: 3, file: file, stencilId: stencilId);

  Future<BaseRespModel> _createAiBoxOrder(
      {required int type,
      required Uint8List file,
      required String? stencilId}) {
    return ApiCode.warp(
      httpInstance.multiPartFormPost(
        url: 'aibox/createAiBoxOrder',
        file: file,
        body: {'type': type, 'stencilId': stencilId},
      ),
    );
  }

  // 自定义换脸-步骤1
  Future<String?> createAiFaceCustomStencil(Uint8List file) async {
    try {
      final resp = await httpInstance.multiPartFormPost(
        url: 'aibox/new/customizeStencil',
        file: file,
      );
      if (resp is Map) {
        final orderNo = resp['orderNo'];
        if (orderNo is String && orderNo.isNotEmpty) {
          return orderNo;
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  // 自定义换脸-步骤2
  Future<BaseRespModel> createAiFaceCustomOrder({
    required Uint8List file,
    required String orderNo,
  }) =>
      _createAiBoxOrderNew(file: file, orderNo: orderNo, type: 4);

  Future<BaseRespModel> _createAiBoxOrderNew({
    required Uint8List file,
    required String orderNo,
    required int type,
  }) {
    return ApiCode.warp(
      httpInstance.multiPartFormPost(
        url: 'aibox/new/createAiBoxOrder',
        file: file,
        body: {'type': type, 'orderNo': orderNo},
      ),
    );
  }

  // 换脸，获取图片和视频的分类
  Future<List<AiStencilClassModel>?> fetchAiFaceVideoClassify() =>
      _fetchAiFaceClassify(1);
  Future<List<AiStencilClassModel>?> fetchAiFaceImageClassify() =>
      _fetchAiFaceClassify(2);
  Future<List<AiStencilClassModel>?> _fetchAiFaceClassify(int type) async {
    try {
      final resp = await httpInstance.get(
        url: 'aibox/getClassify',
        queryMap: {
          'page': Consts.pageFirst,
          'pageSize': 100, //一次获取完
          'type': type,
        },
        complete: AiStencilClassModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  Future<List<AiStencilModel>?> fetchAiFaceImageStencil({
    required int page,
    required int pageSize,
    int? classId,
    required int sortType,
    required bool sortAsc,
  }) =>
      _fetchAiFaceStencil(
        page: page,
        pageSize: pageSize,
        type: 2,
        classId: classId,
        sortType: sortType,
        sortAsc: sortAsc,
      );

  Future<List<AiStencilModel>?> fetchAiFaceVideoStencil({
    required int page,
    required int pageSize,
    int? classId,
    required int sortType,
    required bool sortAsc,
  }) =>
      _fetchAiFaceStencil(
        page: page,
        pageSize: pageSize,
        type: 3,
        classId: classId,
        sortType: sortType,
        sortAsc: sortAsc,
      );

  Future<List<AiStencilModel>?> _fetchAiFaceStencil({
    required int page,
    required int pageSize,
    required int type, //2:图片换脸；3:视频换脸
    int? classId,
    required int sortType,
    required bool sortAsc,
  }) async {
    try {
      final resp = await httpInstance.get(
        url: 'aibox/getAllStencil',
        queryMap: {
          'page': page,
          'pageSize': pageSize,
          'type': type,
          'classId': classId,
          'sortType': sortType,
          'asc': sortAsc,
        },
        complete: AiStencilModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  // 获取图片去衣订单记录
  Future<List<AiRcRecordV2Model>?> fetchAiClothRecordV2({
    required int type,
    required AiRecordStatus status,
    required int page,
    required int pageSize,
  }) async {
    try {
      final resp = await httpInstance.get(
        url: 'aibox/getAiRcRecordV2',
        queryMap: {
          'type': type,
          'status': status,
          'page': page,
          'pageSize': pageSize
        },
        complete: AiRcRecordV2Model.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  // 获取视频换脸记录
  Future<AiHandleRecordModelResp?> fetchAiFaceRecord({
    required int type,
    required AiRecordStatus status,
    required int page,
    required int pageSize,
  }) async {
    try {
      final raw = await httpInstance.get(
        url: 'aibox/getAiRecord',
        queryMap: {
          'type': type,
          'status': status,
          'page': page,
          'pageSize': pageSize
        },
      );
      final resp = AiHandleRecordModelResp.fromJson(raw);
      return resp;
    } catch (e) {
      return null;
    }
  }

  Future<bool?> delOneAiRecord(String tradeNo) async {
    try {
      await httpInstance.post(
        url: 'aibox/delOneAiRecord',
        body: {'tradeNo': tradeNo},
      );
      return true;
    } catch (e) {
      return null;
    }
  }

  Future<bool> delAiRecord(
      {required int type, required AiRecordStatus status}) async {
    try {
      await httpInstance.post(
        url: 'aibox/delAiRecord',
        body: {'status': status, 'type': type},
      );
      return true;
    } catch (e) {
      return false;
    }
  }
}
