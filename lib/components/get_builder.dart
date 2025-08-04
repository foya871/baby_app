import 'package:get/get.dart';

class LocalGetBuilder<T extends GetxController> extends GetBuilder<T> {
  LocalGetBuilder({
    super.key,
    super.id,
    super.init,
    required super.builder,
  }) : super(
          global: false,
          dispose: (state) => state.controller?.isClosed != true
              ? state.controller?.onClose()
              : null,
        );
}

class NoAutoRemoveGetBuilder<T extends GetxController> extends GetBuilder<T> {
  const NoAutoRemoveGetBuilder({
    super.key,
    super.tag,
    super.id,
    required super.builder,
  }) : super(autoRemove: false);
}
