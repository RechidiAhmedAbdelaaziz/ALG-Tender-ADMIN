import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tender_admin/core/di/locator.dart';
import 'package:tender_admin/core/extension/list.extension.dart';
import 'package:tender_admin/core/types/cubitstate/error.state.dart';
import 'package:tender_admin/features/tender/data/dto/tender_filters.dto.dart';
import 'package:tender_admin/features/tender/data/models/tender.model.dart';
import 'package:tender_admin/features/tender/data/repository/tender.repo.dart';

part 'tenders.state.dart';

class TendersCubit extends Cubit<TendersState> {
  final _repo = locator<TenderRepo>();
  final _paginationDto = TenderFiltersDto();

  TendersCubit() : super(TendersState.initial());

  TenderFiltersDto get filters => _paginationDto;

  void filterTenders() {
    state.tenders.clear();
    _paginationDto.firstPage();
    loadTenders();
  }

  void loadTenders() async {
    emit(state._loading());

    final tenders = await _repo.getTenders(_paginationDto);

    tenders.when(
      success: (result) {
        if (result.data.isNotEmpty) _paginationDto.nextPage();
        emit(state._loaded(result.data));
      },
      error: (error) => emit(state._error(error.message)),
    );
  }

  void addTender(TenderModel tender) => emit(state._add(tender));

  void updateTender(TenderModel tender) =>
      emit(state._update(tender));

  void deleteTender(TenderModel tender) async {
    emit(state._loading());
    final result = await _repo.deleteTender(tender);

    result.when(
      success: (_) => emit(state._delete(tender)),
      error: (error) => emit(state._error(error.message)),
    );
  }

  @override
  Future<void> close() {
    _paginationDto.dispose();
    state.tenders.clear();
    return super.close();
  }
}
