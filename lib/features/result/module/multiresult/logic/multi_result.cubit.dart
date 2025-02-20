import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tender_admin/core/di/locator.dart';
import 'package:tender_admin/core/extension/list.extension.dart';
import 'package:tender_admin/core/types/cubitstate/error.state.dart';
import 'package:tender_admin/features/result/data/dto/result.filters.dart';
import 'package:tender_admin/features/result/data/models/result.model.dart';
import 'package:tender_admin/features/result/data/repository/result.repo.dart';

part 'multi_result.state.dart';

class MultiResultCubit extends Cubit<MultiResultState> {
  final _repo = locator<ResultRepo>();
  final ResultFiltersDto _paginationDto;

  MultiResultCubit(String tenderId)
      : _paginationDto = ResultFiltersDto(tenderId),
        super(MultiResultState.initial());

  ResultFiltersDto get filters => _paginationDto;

  void filterResults() {
    state.results.clear();
    _paginationDto.firstPage();
    loadResults();
  }

  void loadResults() async {
    emit(state._loading());

    final results = await _repo.getResults(_paginationDto);

    results.when(
      success: (result) {
        if (result.data.isNotEmpty) _paginationDto.nextPage();
        emit(state._loaded(result.data));
      },
      error: (error) => emit(state._error(error.message)),
    );
  }

  void addResult(ResultModel result) => emit(state._add(result));

  void updateResult(ResultModel result) =>
      emit(state._update(result));

  void deleteResult(ResultModel model) async {
    emit(state._loading());
    final result = await _repo.deleteResult(model);

    result.when(
      success: (_) => emit(state._delete(model)),
      error: (error) => emit(state._error(error.message)),
    );
  }

  @override
  Future<void> close() {
    _paginationDto.dispose();
    state.results.clear();
    return super.close();
  }
}
