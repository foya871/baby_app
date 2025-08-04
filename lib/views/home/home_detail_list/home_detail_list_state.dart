import 'package:get/get.dart';

class HomeDetailListState {
  HomeDetailListState() {
    ///Initialize variables
  }
  var vertical = false.obs;
  List<String> list1 = ["最新上架", "最多观看", "热门推荐"];
  List<String> list2 = ["全部", "长篇小说", "短片小说"];
  int index1 = 0;
  int index2 = 0;
}
