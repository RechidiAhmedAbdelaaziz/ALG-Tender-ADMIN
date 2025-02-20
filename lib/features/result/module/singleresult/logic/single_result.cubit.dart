import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tender_admin/core/di/locator.dart';
import 'package:tender_admin/core/types/cubitstate/error.state.dart';
import 'package:tender_admin/features/result/data/dto/result.dto.dart';
import 'package:tender_admin/features/result/data/models/result.model.dart';
import 'package:tender_admin/features/result/data/repository/result.repo.dart';

part 'single_result.state.dart';

class SingleResultCubit extends Cubit<SingleResultState> {
  final _repo = locator<ResultRepo>();
  SingleResultCubit() : super(SingleResultState.initial());

  void loadResult([String? id]) async {
    emit(state._loading());

    if (id == null) {
      emit(state._loaded(CreateResultDTO()));
      return;
    }

    final result = await _repo.getResult(id);

    result.when(
      success: (model) => emit(state._loaded(UpdateResultDTO(model))),
      error: (error) => emit(state._error(error.message)),
    );
  }

  void saveResult() async {
    emit(state._saving());

    final dto = state.dto;

    final result = dto is CreateResultDTO
        ? await _repo.createResult(dto)
        : await _repo.updateResult(dto as UpdateResultDTO);

    result.when(
      success: (model) => emit(state._saved(model)),
      error: (error) => emit(state._error(error.message)),
    );
  }

  @override
  Future<void> close() {
    state.dto.dispose();
    return super.close();
  }
}
