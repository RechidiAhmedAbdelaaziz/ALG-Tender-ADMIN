import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tender_admin/core/di/locator.dart';
import 'package:tender_admin/core/extension/list.extension.dart';
import 'package:tender_admin/core/shared/dto/pagination/pagination.dto.dart';
import 'package:tender_admin/core/types/cubitstate/error.state.dart';
import 'package:tender_admin/features/newspaper/data/dto/newspaper.dto.dart';
import 'package:tender_admin/features/newspaper/data/models/newspaper.model.dart';
import 'package:tender_admin/features/newspaper/data/repository/newspaper.repo.dart';

part 'newspaper.state.dart';

class NewsPaperCubit extends Cubit<NewsPaperState> {
  final _repo = locator<NewsPaperRepo>();
  final _pagination = PaginationDto();

  NewsPaperCubit() : super(NewsPaperState.initial());

  void searchNewsPapers() {
    _pagination.firstPage();
    getNewsPapers();
  }

  void selectNewsPaper(NewsPaperModel model) =>
      emit(state._selected(model));

  void getNewsPapers() async {
    emit(state._loading());
    final result = await _repo.getNewsPapers(_pagination);

    result.when(
      success: (pagination) {
        if (pagination.data.isNotEmpty) _pagination.nextPage();
        emit(state._loaded(pagination.data));
      },
      error: (error) => emit(state._error(error.message)),
    );
  }

  void createNewsPaper(CreateNewspaperDto dto) async {
    emit(state._loading());
    final result = await _repo.createNewsPaper(dto);
    dto.dispose();

    result.when(
      success: (newspaper) => emit(state._created(newspaper)),
      error: (error) => emit(state._error(error.message)),
    );
  }

  void updateNewsPaper(UpdateNewspaperDto dto) async {
    emit(state._updating(dto.model));
    final result = await _repo.updateNewsPaper(dto);
    dto.dispose();

    result.when(
      success: (newspaper) => emit(state._updated(newspaper)),
      error: (error) => emit(state._error(error.message)),
    );
  }

  void deleteNewsPaper(NewsPaperModel model) async {
    emit(state._updating(model));
    final result = await _repo.deleteNewsPaper(model);


    result.when(
      success: (_) => emit(state._deleted(model)),
      error: (error) => emit(state._error(error.message)),
    );
  }
  
  @override
  Future<void> close() {
    _pagination.dispose();
    return super.close();
  }
  
}
