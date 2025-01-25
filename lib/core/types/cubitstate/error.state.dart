class ErrorState {
  final String? _error;

  ErrorState(this._error);

  void onError(void Function(String?) onError) {
    onError(_error);
  }
}
