import '../../utils/consts.dart';

mixin BaseRefreshPageCounter {
  int _page = Consts.pageFirst;

  void incPage() => _page++;

  void resetPage([int? resetTo]) => _page = resetTo ?? Consts.pageFirst;

  bool get isFirstPage => page == Consts.pageFirst;

  int get page => _page;
}
