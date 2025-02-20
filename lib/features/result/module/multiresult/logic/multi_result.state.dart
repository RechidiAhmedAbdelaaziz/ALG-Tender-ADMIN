// ignore_for_file: library_private_types_in_public_api

part of 'multi_result.cubit.dart';

enum _MultiResultStatus { initial, loading, loaded, error }

class MultiResultState extends ErrorState {
  final List<ResultModel> results;
  final _MultiResultStatus _status;

  MultiResultState({
    required this.results,
    _MultiResultStatus status = _MultiResultStatus.initial,
    String? error,
  })  : _status = status,
        super(error);

  factory MultiResultState.initial() => MultiResultState(results: []);

  bool get isLoading => _status == _MultiResultStatus.loading;

  MultiResultState _loading() =>
      _copyWith(status: _MultiResultStatus.loading);

  MultiResultState _loaded(List<ResultModel> results) {
    return _copyWith(
      results: this.results.withAllUnique(results),
      status: _MultiResultStatus.loaded,
    );
  }

  MultiResultState _add(ResultModel result) {
    return _copyWith(
      results: results.withUnique(result),
      status: _MultiResultStatus.loaded,
    );
  }

  MultiResultState _update(ResultModel result) {
    return _copyWith(
      results: results.withReplace(result),
      status: _MultiResultStatus.loaded,
    );
  }

  MultiResultState _delete(ResultModel result) {
    return _copyWith(
      results: results.without(result),
      status: _MultiResultStatus.loaded,
    );
  }

  MultiResultState _error(String error) =>
      _copyWith(status: _MultiResultStatus.error, error: error);

  MultiResultState _copyWith({
    List<ResultModel>? results,
    _MultiResultStatus? status,
    String? error,
  }) {
    return MultiResultState(
      results: results ?? this.results,
      status: status ?? _status,
      error: error,
    );
  }
}
