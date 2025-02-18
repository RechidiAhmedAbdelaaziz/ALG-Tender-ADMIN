import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tender_admin/core/di/locator.dart';
import 'package:tender_admin/core/types/cubitstate/error.state.dart';
import 'package:tender_admin/features/tender/data/dto/tender.dto.dart';
import 'package:tender_admin/features/tender/data/models/tender.model.dart';
import 'package:tender_admin/features/tender/data/repository/tender.repo.dart';

part 'tender.state.dart';

class TenderCubit extends Cubit<TenderState> {
  final _repo = locator<TenderRepo>();
  TenderCubit() : super(TenderState.initial());

  void loadTender([String? id]) async {
    emit(state._loading());

    if (id == null) {
      emit(state._loaded(CreateTenderDTO()));
      return;
    }

    final result = await _repo.getTender(id);

    result.when(
      success: (model) => emit(state._loaded(UpdateTenderDTO(model))),
      error: (error) => emit(state._error(error.message)),
    );
  }

  void saveTender() async {
    emit(state._saving());

    final dto = state.dto;

   

    final result = dto is CreateTenderDTO
        ? await _repo.createTender(dto)
        : await _repo.updateTender(dto as UpdateTenderDTO);

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
