import 'package:baby_app/views/shi_pin/controllers/station/station_detail_with_sorting_page_controller.dart';
import 'package:get/get.dart';

class StationDetailWithSortingPageBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StationDetailWithSortingPageController());
  }
}
