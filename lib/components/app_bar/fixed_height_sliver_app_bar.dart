import 'package:flutter/material.dart';

class FixedHeightSliverAppBar extends StatelessWidget {
  final double height;
  final Widget child;
  final Alignment alignment;
  final bool pinned;
  final bool floating;

  const FixedHeightSliverAppBar({
    super.key,
    required this.height,
    required this.child,
    this.alignment = Alignment.center,
    this.pinned = false,
    this.floating = false,
  });
  @override
  Widget build(BuildContext context) => SliverPersistentHeader(
        delegate: _HeaderDelegate(
          Align(
            alignment: alignment,
            child: child,
          ),
          height: height,
        ),
        pinned: pinned,
        floating: floating,
      );
}

class _HeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double height;
  _HeaderDelegate(this.child, {required this.height});
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Align(alignment: Alignment.centerLeft, child: child);
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
