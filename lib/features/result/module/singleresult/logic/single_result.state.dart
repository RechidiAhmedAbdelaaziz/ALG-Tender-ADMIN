// ignore_for_file: library_private_types_in_public_api

part of 'single_result.cubit.dart';

enum _SingleResultStatus { initial, loading, saving, loaded, error }

class SingleResultState extends ErrorState {
  final ResultDTO? _dto;
  final _SingleResultStatus _status;

  SingleResultState({
    ResultDTO? dto,
    _SingleResultStatus status = _SingleResultStatus.initial,
    String? error,
  })  : _dto = dto,
        _status = status,
        super(error);

  factory SingleResultState.initial() => SingleResultState();

  bool get isLoading => _status == _SingleResultStatus.loading;
  bool get isSaving => _status == _SingleResultStatus.saving;
  bool get isLoaded => _dto != null;
  ResultDTO get dto => _dto!;

  SingleResultState _loading() =>
      _copyWith(status: _SingleResultStatus.loading);
  SingleResultState _saving() =>
      _copyWith(status: _SingleResultStatus.saving);

  SingleResultState _loaded(ResultDTO dto) =>
      _copyWith(dto: dto, status: _SingleResultStatus.loaded);

  SingleResultState _saved(ResultModel model) =>
      _SavedSingleResultState(model, this);

  SingleResultState _error(String error) =>
      _copyWith(error: error, status: _SingleResultStatus.error);

  SingleResultState _copyWith({
    ResultDTO? dto,
    _SingleResultStatus? status,
    String? error,
  }) {
    return SingleResultState(
      dto: dto ?? _dto,
      status: status ?? _status,
      error: error,
    );
  }

  void onSave(void Function(ResultModel) callback) {}
}

class _SavedSingleResultState extends SingleResultState {
  final ResultModel result;
  _SavedSingleResultState(this.result, SingleResultState state)
      : super(dto: state.dto, status: _SingleResultStatus.loaded);

  @override
  void onSave(void Function(ResultModel p1) callback) =>
      callback(result);
}
