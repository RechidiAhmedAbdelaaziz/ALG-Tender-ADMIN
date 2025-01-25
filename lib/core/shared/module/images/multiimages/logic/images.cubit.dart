import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tender_admin/core/shared/dto/imagedto/image.dto.dart';

import '../../singleimage/logic/image.cubit.dart';


part 'images.state.dart';

class ImagesCubit extends Cubit<ImagesState> {
  ImagesCubit([List<ImageDTO>? images])
      : super(ImagesState.initial(images));

  void addImage() => emit(state._addImage());

  void removeImage(ImageCubit image) =>
      emit(state._removeImage(image));

  @override
  Future<void> close() {
    for (var element in state.imageCubits) {
      element.close();
    }
    return super.close();
  }
}
