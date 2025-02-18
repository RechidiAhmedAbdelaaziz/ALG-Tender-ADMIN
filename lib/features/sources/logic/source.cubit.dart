import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tender_admin/core/extension/list.extension.dart';
import 'package:tender_admin/core/shared/classes/editioncontollers/list_generic_editingcontroller.dart';
import 'package:tender_admin/features/sources/data/dto/source.dto.dart';

part 'source.state.dart';

class SourceCubit extends Cubit<SourceState> {
  SourceCubit(ListEditingcontroller<SourceDTO> sources)
      : super(SourceState.initial(sources.value));

  void addSource(SourceDTO source) {
    // _sources.addValue(source);
    emit(state._add(source));
  }

  void removeSource(SourceDTO source) {
    // _sources.removeValue(source);
    emit(state._remove(source));
  }

  void replaceSource(SourceDTO source) {
    // _sources.replaceValue(source);
    emit(state._replace(source));
  }
}
