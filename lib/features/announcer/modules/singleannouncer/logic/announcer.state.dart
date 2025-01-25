part of 'announcer.cubit.dart';

enum _AnnouncerStatus { initial, loading, saved }

class AnnouncerState<T extends AnnouncerDto> extends ErrorState {
  final T _announcerDto;
  final AnnouncerModel? _model;
  final _AnnouncerStatus _status;

  AnnouncerState._({
    required T announcerDto,
    _AnnouncerStatus? status,
    AnnouncerModel? model,
    String? error,
  })  : _announcerDto = announcerDto,
        _status = status ?? _AnnouncerStatus.initial,
        _model = model,
        super(error);

  factory AnnouncerState.initial(T dto) =>
      AnnouncerState._(announcerDto: dto);

  AnnouncerState<T> _loading() =>
      _copyWith(status: _AnnouncerStatus.loading);

  AnnouncerState<T> _saved(AnnouncerModel model) =>
      _copyWith(status: _AnnouncerStatus.saved, model: model);

  AnnouncerState<T> _error(String error) => _copyWith(error: error);

  AnnouncerState<T> _copyWith({
    T? announcerDto,
    _AnnouncerStatus? status,
    AnnouncerModel? model,
    String? error,
  }) =>
      AnnouncerState<T>._(
        announcerDto: announcerDto ?? _announcerDto,
        status: status ?? _status,
        model: model ?? _model,
        error: error,
      );

  void onSaved(void Function(AnnouncerModel model) callback) {
    if (_status == _AnnouncerStatus.saved) callback(_model!);
  }

  T get dto => _announcerDto;

  bool get isLoading => _status == _AnnouncerStatus.loading;

}
