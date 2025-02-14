part of 'newspaper.cubit.dart';

enum NewspaperStatus {
  loading,
  loaded,
  error,
}

class NewsPaperState extends ErrorState {
  final List<NewsPaperModel> newspapers;
  final NewsPaperModel? _selectedNewspaper;
  final NewsPaperModel? _updatingNewspaper;
  final NewspaperStatus _status;

  NewsPaperState({
    required this.newspapers,
    NewsPaperModel? selectedNewspaper,
    NewsPaperModel? updatingNewspaper,
    NewspaperStatus status = NewspaperStatus.loading,
    String? error,
  })  : _status = status,
        _selectedNewspaper = selectedNewspaper,
        _updatingNewspaper = updatingNewspaper,
        super(error);

  factory NewsPaperState.initial(
          [NewsPaperModel? selectedNewspaper]) =>
      NewsPaperState(
        newspapers:
            selectedNewspaper != null ? [selectedNewspaper] : [],
        selectedNewspaper: selectedNewspaper,
      );

  bool get isLoading => _status == NewspaperStatus.loading;

  bool isUpdating(NewsPaperModel newspaper) =>
      _updatingNewspaper == newspaper;

  NewsPaperModel get selectedNewspaper => _selectedNewspaper!;

  NewsPaperState _loading() =>
      _copyWith(status: NewspaperStatus.loading);

  NewsPaperState _updating(NewsPaperModel newspaper) =>
      _copyWith(updatingNewspaper: newspaper);

  NewsPaperState _loaded(List<NewsPaperModel> newspapers) =>
      _copyWith(
        newspapers: this.newspapers.withAllUnique(newspapers),
        selectedNewspaper: _selectedNewspaper ?? newspapers.first,
        status: NewspaperStatus.loaded,
      );

  NewsPaperState _created(NewsPaperModel newspaper) => _copyWith(
        newspapers: newspapers.withUnique(newspaper),
        status: NewspaperStatus.loaded,
      );

  NewsPaperState _updated(NewsPaperModel newspaper) => _copyWith(
        newspapers: newspapers.withReplace(newspaper),
        status: NewspaperStatus.loaded,
      );

  NewsPaperState _deleted(NewsPaperModel newspaper) => _copyWith(
        newspapers: newspapers.without(newspaper),
        selectedNewspaper: selectedNewspaper == newspaper
            ? newspapers.firstOrNull
            : selectedNewspaper,
        status: NewspaperStatus.loaded,
      );

  NewsPaperState _selected(NewsPaperModel selectedNewspaper) =>
      _copyWith(
          selectedNewspaper: selectedNewspaper,
          status: NewspaperStatus.loaded);

  NewsPaperState _error(String error) =>
      _copyWith(status: NewspaperStatus.error, error: error);

  NewsPaperState _copyWith({
    List<NewsPaperModel>? newspapers,
    NewsPaperModel? selectedNewspaper,
    NewsPaperModel? updatingNewspaper,
    NewspaperStatus? status,
    String? error,
  }) {
    return NewsPaperState(
      newspapers: newspapers ?? this.newspapers,
      selectedNewspaper: selectedNewspaper ?? _selectedNewspaper,
      updatingNewspaper: updatingNewspaper,
      status: status ?? _status,
      error: error,
    );
  }
}
