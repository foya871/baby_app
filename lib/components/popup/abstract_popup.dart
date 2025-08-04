import 'package:flutter/material.dart';

abstract class AbstractPopup<T> {
  Widget build();
  Future<T?> show();
}
