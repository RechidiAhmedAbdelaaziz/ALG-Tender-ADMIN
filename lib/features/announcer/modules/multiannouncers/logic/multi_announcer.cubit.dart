import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tender_admin/core/di/locator.dart';
import 'package:tender_admin/core/network/types/api_result.type.dart';
import 'package:tender_admin/core/shared/dto/pagination/pagination.dto.dart';
import 'package:tender_admin/core/types/cubitstate/error.state.dart';
import 'package:tender_admin/features/announcer/data/models/announcer.model.dart';
import 'package:tender_admin/features/announcer/data/repository/announcer.repo.dart';

part 'multi_announcer.state.dart';

class MultiAnnouncerCubit extends Cubit<MultiAnnouncerState> {
  final _announcerRepo = locator<AnnouncerRepo>();
  final _paginationDto = PaginationDto();

  MultiAnnouncerCubit() : super(MultiAnnouncerState.initial());

  void search() {
    _paginationDto.page.setValue(1);
    state._result.clear();
    load();
  }

  TextEditingController get searchController =>
      _paginationDto.keyword;

  void load() async {
    emit(state._loading());

    final result = await _announcerRepo.getAnnouncers(_paginationDto);

    result.when(
      success: (result) {
        if (result.data.isNotEmpty) _paginationDto.page.increment();
        emit(state._loaded(result));
      },
      error: (error) => emit(state._error(error.message)),
    );
  }

  void add(AnnouncerModel announcer) {
    emit(state._loading());
    final result = state._result.add(announcer);
    emit(state._loaded(result));
  }

  void remove(AnnouncerModel announcer) async {
    emit(state._loading());
    final result = await _announcerRepo.deleteAnnouncer(announcer);
    result.when(
      success: (_) {
        final result = state._result.remove(announcer);
        emit(state._loaded(result));
      },
      error: (error) => emit(state._error(error.message)),
    );
  }

  void update(AnnouncerModel announcer) {
    emit(state._loading());
    final result = state._result.replace(announcer);
    emit(state._loaded(result));
  }
}
