// ignore_for_file: library_private_types_in_public_api

part of 'multi_announcer.cubit.dart';

enum _AnnouncersStates { initial, loading, loaded, error }

class MultiAnnouncerState extends ErrorState {
  final PaginationResult<AnnouncerModel> _result;
  final _AnnouncersStates _state;

  MultiAnnouncerState._({
    PaginationResult<AnnouncerModel>? result,
    _AnnouncersStates? state,
    String? error,
  })  : _result = result ?? PaginationResult<AnnouncerModel>(),
        _state = state ?? _AnnouncersStates.initial,
        super(error);

  factory MultiAnnouncerState.initial() => MultiAnnouncerState._();

  MultiAnnouncerState _loading() =>
      _copyWith(state: _AnnouncersStates.loading);

  MultiAnnouncerState _loaded(
          PaginationResult<AnnouncerModel> result) =>
      _copyWith(
        result: _result.addAll(result),
        state: _AnnouncersStates.loaded,
      );

  MultiAnnouncerState _error(String error) =>
      _copyWith(error: error, state: _AnnouncersStates.error);

  MultiAnnouncerState _copyWith({
    PaginationResult<AnnouncerModel>? result,
    _AnnouncersStates? state,
    String? error,
  }) {
    return MultiAnnouncerState._(
      result: result ?? _result,
      state: state ?? _state,
      error: error,
    );
  }

  bool get isLoading => _state == _AnnouncersStates.loading;
  bool get isLoaded => _state == _AnnouncersStates.loaded;

  List<AnnouncerModel> get announcers => _result.data;
}
