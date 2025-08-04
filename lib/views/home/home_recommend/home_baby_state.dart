import 'package:get/get_rx/get_rx.dart';

class HomeBabyState {
  var tabs = ["热门推荐", "最新上架", "最多观看"];
  List<String> list1 = ["最近更新", "本周最热", "最多观看", "十分钟以上"];
  RxInt index1 = 0.obs;
  HomeBabyState() {
    ///Initialize variables
  }
}
