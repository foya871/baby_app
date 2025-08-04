import 'package:flutter/material.dart';

import 'shi_pin_tab_base_widget.dart';

class ShiPinTabEmptyWidget extends ShiPinTabBaseWidget {
  const ShiPinTabEmptyWidget({super.key, required super.controllerTag});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
