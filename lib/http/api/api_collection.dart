part of 'api.dart';

// ignore: library_private_types_in_public_api
extension ApiCollection on _Api {
  // toogle收藏合集
  Future<bool> toogleBloggerCollectionFavorite(int collectionId,
      {required bool? favorite}) async {
    try {
      if (favorite == true) {
        await httpInstance.post(
          url: 'bloggerCollection/cancelFavorite',
          body: {'collectionId': collectionId},
        );
      } else {
        await httpInstance.post(
          url: 'bloggerCollection/favorite',
          body: {'collectionId': collectionId},
        );
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  // 查询合集详情
  Future<CollectionDetailModel?> fetchBloggerCollectionDetail(
      int collectionId) async {
    try {
      final resp = await httpInstance.get(
        url: 'bloggerCollection/queryCollectionDetails',
        queryMap: {'collectionId': collectionId},
        complete: CollectionDetailModel.fromJson,
      );
      return resp;
    } catch (e) {
      return null;
    }
  }
}
