import 'package:uuid/uuid.dart';

class UUID {
  UUID._();
  static const Uuid _uuid = Uuid();

  static String generate() => _uuid.v4();
}
