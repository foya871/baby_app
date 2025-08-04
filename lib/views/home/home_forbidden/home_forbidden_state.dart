import 'package:get/get.dart';

class HomeForbiddenState {
  HomeForbiddenState() {
    ///Initialize variables
  }

  var tabs = ["热门推荐", "最新上架", "最多观看"];
  var vertical = false.obs;
  List<String> list1 = ["最近更新", "本周最热", "最多观看", "十分钟以上"];
  List<String> list2 = ["全部", "长篇小说", "短片小说"];
  int index1 = 0;
  int index2 = 0;
}
