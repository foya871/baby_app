import 'base_data_keeper.dart';
import 'base_refresh_data_keeper.dart';
import 'base_refresh_page_counter.dart';
import 'base_refresh_single_controller.dart';
import 'base_refresh_simple_widget.dart';

///
/// 页面中 一个GetxController, 一个refersh_controller, 没有tab
/// 一个页面使用一个 see: [BaseRefreshSimpleWidget]
///

abstract class BaseRefreshSimpleController<E>
    extends BaseRefreshSingleContronller
    with BaseDataKeeper<E>, BaseRefreshPageCounter, BaseRefreshDataKeeper {}
