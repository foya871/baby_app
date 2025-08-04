import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AiBytesImage {
  final Uint8List bytes;
  final MemoryImage imageProvider;

  AiBytesImage.empty()
      : bytes = Uint8List.fromList([]),
        imageProvider = MemoryImage(Uint8List.fromList([]));

  bool get isEmpty => bytes.isEmpty;

  AiBytesImage({required this.bytes}) : imageProvider = MemoryImage(bytes);
}
