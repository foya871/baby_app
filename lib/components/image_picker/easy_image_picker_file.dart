import 'dart:io';
import 'dart:typed_data';

// ignore: depend_on_referenced_packages
import 'package:cross_file/cross_file.dart';

class EasyImagePickerFile {
  final XFile? _xfile;
  final File? _file;
  final String name;
  final String path;

  Future<Uint8List?> get bytes {
    try {
      return bytesUnsafe;
    } catch (e) {
      return Future.value(null);
    }
  }

  Future<Uint8List> get bytesUnsafe {
    if (_xfile != null) {
      return _xfile.readAsBytes();
    }
    return _file!.readAsBytes();
  }

  Future<int?> get length {
    try {
      return lengthUnsafe;
    } catch (e) {
      return Future.value(null);
    }
  }

  Future<int> get lengthUnsafe {
    if (_xfile != null) {
      return _xfile.length();
    }
    return _file!.length();
  }

  Stream<List<int>> openRead([int? start, int? end]) {
    if (_xfile != null) {
      return _xfile.openRead(start, end);
    }
    return _file!.openRead(start, end);
  }

  EasyImagePickerFile({
    XFile? xfile,
    File? file,
    required this.name,
    required this.path,
  })  : _xfile = xfile,
        _file = file;
}
