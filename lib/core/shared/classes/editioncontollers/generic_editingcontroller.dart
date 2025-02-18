import 'package:flutter/material.dart';

class EditingController<T> extends ValueNotifier<T?> {
  EditingController([super._value]);

  void setValue(T value) => this.value = value;

  void clear() => value = null;
}
