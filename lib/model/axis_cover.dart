enum CoverImgAxis { horizontal, vertical }

abstract class AxisCover {
  String get hCover;
  String get vCover;
  String coverByAxis(CoverImgAxis axis) =>
      axis == CoverImgAxis.horizontal ? hCover : vCover;
}
