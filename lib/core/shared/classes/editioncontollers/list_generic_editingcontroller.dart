import 'package:flutter/material.dart';
import 'package:tender_admin/core/extension/list.extension.dart';

class ListEditingcontroller<T> extends ValueNotifier<List<T>> {
  ListEditingcontroller([List<T>? value]) : super(value ?? []);

  void addValue(T value) => this.value.addUnique(value);

  void removeValue(T value) => this.value.remove(value);

  void replaceValue(T value) => this.value.replace(value);

  void clear() => value = [];

  void addValues(List<T> values) => value.addAllUnique(values);

  void removeValues(List<T> values) =>
      value.removeWhere((element) => values.contains(element));

  void setList(List<T> value) => this.value = value;
}
