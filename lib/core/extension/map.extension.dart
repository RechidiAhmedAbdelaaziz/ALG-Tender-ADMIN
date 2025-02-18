extension MapExtension<T, V> on Map<T, V> {
  Map<T, V> withoutNulls() {
    return Map<T, V>.fromEntries(
      entries.where((element) => element.value != null ),
    );
  }
}
