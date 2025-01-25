import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tender_admin/core/di/locator.dart';
import 'package:tender_admin/core/services/filepicker/filepick.service.dart';
import 'package:tender_admin/core/shared/dto/imagedto/image.dto.dart';

part 'image.state.dart';

class ImageCubit extends Cubit<ImageState> {
  final _picPicker = locator<FilePickerService>();
  ImageCubit([ImageDTO? image]) : super(ImageState.initial(image)) {
    if (image != null) loadImage();
  }

  void loadImage() async {
    emit(state._loading());
    try {
      final image = await state._imageDTO!.image;
      emit(state._ready(image));
    } catch (e) {
      emit(state._error(e.toString()));
    }
  }

  void pickImage() async {
    final image = await _picPicker.pickFile();
    if (image != null) {
      emit(state._loaded(image));
      loadImage();
    }
  }

  void removeImage() => emit(state._removed());
}
