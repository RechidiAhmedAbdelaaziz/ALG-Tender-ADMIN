import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tender_admin/core/di/locator.dart';
import 'package:tender_admin/core/types/cubitstate/error.state.dart';
import 'package:tender_admin/features/announcer/data/dto/announcer.dto.dart';
import 'package:tender_admin/features/announcer/data/models/announcer.model.dart';

import '../../../data/repository/announcer.repo.dart';

part 'announcer.state.dart';

abstract class AnnouncerCubit<T extends AnnouncerDto>
    extends Cubit<AnnouncerState<T>> {
  final _announcerRepo = locator<AnnouncerRepo>();

  AnnouncerCubit(T dto) : super(AnnouncerState.initial(dto));

  void save();

  bool get isEdit;
}

class CreateAnnouncerCubit
    extends AnnouncerCubit<CreateAnnouncerDto> {
  CreateAnnouncerCubit() : super(CreateAnnouncerDto());

  @override
  final isEdit = false;

  @override
  void save() async {
    emit(state._loading());

    final result =
        await _announcerRepo.createAnnouncer(state._announcerDto);

    result.when(
      success: (result) {
        emit(state._saved(result));
      },
      error: (error) => emit(state._error(error.message)),
    );
  }
}

class UpdateAnnouncerCubit
    extends AnnouncerCubit<UpdateAnnouncerDto> {
  UpdateAnnouncerCubit(AnnouncerModel model)
      : super(UpdateAnnouncerDto(model));

  @override
  final isEdit = true;

  @override
  void save() async {
    emit(state._loading());

    final result =
        await _announcerRepo.updateAnnouncer(state._announcerDto);

    result.when(
      success: (result) {
        emit(state._saved(result));
      },
      error: (error) => emit(state._error(error.message)),
    );
  }
}
