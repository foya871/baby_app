abstract class BaseRefreshTabKey {
  String toKey();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is BaseRefreshTabKey && other.toKey() == toKey();
  }

  @override
  int get hashCode => toKey().hashCode;
}

class BaseRefreshTabIndexKey extends BaseRefreshTabKey {
  final int index;

  BaseRefreshTabIndexKey(this.index);

  @override
  String toKey() => '$index';
}

// 两层
class BaseRefreshTabIndex2Key extends BaseRefreshTabKey {
  final int index1;
  final int index2;

  BaseRefreshTabIndex2Key(this.index1, this.index2);

  @override
  String toKey() => '$index1-$index2';
}

// 三层
class BaseRefreshTabIndex3Key extends BaseRefreshTabKey {
  final int index1;
  final int index2;
  final int index3;

  BaseRefreshTabIndex3Key(this.index1, this.index2, this.index3);

  @override
  String toKey() => '$index1-$index2-$index3';
}
