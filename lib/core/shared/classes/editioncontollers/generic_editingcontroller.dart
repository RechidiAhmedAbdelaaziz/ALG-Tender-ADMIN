import 'package:flutter/material.dart';

class Editingcontroller<T> extends ValueNotifier<T?> {
  Editingcontroller([super._value]);

  void setValue(T value) => this.value = value;
}
