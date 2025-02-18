// ignore_for_file: library_private_types_in_public_api

part of 'tender.cubit.dart';

enum _TenderStatus { initial, loading, saving,loaded, error }

class TenderState extends ErrorState {
  final TenderDto? _dto;
  final _TenderStatus _status;

  TenderState({
    TenderDto? dto,
    _TenderStatus status = _TenderStatus.initial,
    String? error,
  })  : _dto = dto,
        _status = status,
        super(error);

  factory TenderState.initial() => TenderState();

  bool get isLoading => _status == _TenderStatus.loading;
  bool get isSaving => _status == _TenderStatus.saving;
  bool get isLoaded => _dto != null;
  TenderDto get dto => _dto!;

  TenderState _loading() => _copyWith(status: _TenderStatus.loading);
  TenderState _saving() => _copyWith(status: _TenderStatus.saving);

  TenderState _loaded(TenderDto dto) =>
      _copyWith(dto: dto, status: _TenderStatus.loaded);

  TenderState _saved(TenderModel model) =>
      _SavedTenderState(model, this);

  TenderState _error(String error) =>
      _copyWith(error: error, status: _TenderStatus.error);

  TenderState _copyWith({
    TenderDto? dto,
    _TenderStatus? status,
    String? error,
  }) {
    return TenderState(
      dto: dto ?? _dto,
      status: status ?? _status,
      error: error,
    );
  }

  void onSave(void Function(TenderModel) callback) {
    if (this is _SavedTenderState) {
      callback((this as _SavedTenderState).tender);
    }
  }
}

class _SavedTenderState extends TenderState {
  final TenderModel tender;
  _SavedTenderState(this.tender, TenderState state)
      : super(dto: state.dto, status: _TenderStatus.loaded);
}
