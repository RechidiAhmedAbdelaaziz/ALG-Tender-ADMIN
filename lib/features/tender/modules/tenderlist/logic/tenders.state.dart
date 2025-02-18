// ignore_for_file: library_private_types_in_public_api

part of 'tenders.cubit.dart';

enum _TendersStatus { initial, loading, loaded, error }

class TendersState extends ErrorState {
  final List<TenderModel> tenders;
  final _TendersStatus _status;

  TendersState({
    required this.tenders,
    _TendersStatus status = _TendersStatus.initial,
    String? error,
  })  : _status = status,
        super(error);

  factory TendersState.initial() => TendersState(tenders: []);

  bool get isLoading => _status == _TendersStatus.loading;

  TendersState _loading() =>
      _copyWith(status: _TendersStatus.loading);

  TendersState _loaded(List<TenderModel> tenders) {
    return _copyWith(
      tenders: this.tenders.withAllUnique(tenders),
      status: _TendersStatus.loaded,
    );
  }

  TendersState _add(TenderModel tender) {
    return _copyWith(
      tenders: tenders.withUnique(tender),
      status: _TendersStatus.loaded,
    );
  }

  TendersState _update(TenderModel tender) {
    return _copyWith(
      tenders: tenders.withReplace(tender),
      status: _TendersStatus.loaded,
    );
  }

  TendersState _delete(TenderModel tender) {
    return _copyWith(
      tenders: tenders.without(tender),
      status: _TendersStatus.loaded,
    );
  }

  TendersState _error(String error) =>
      _copyWith(status: _TendersStatus.error, error: error);

  TendersState _copyWith({
    List<TenderModel>? tenders,
    _TendersStatus? status,
    String? error,
  }) {
    return TendersState(
      tenders: tenders ?? this.tenders,
      status: status ?? _status,
      error: error,
    );
  }
}
