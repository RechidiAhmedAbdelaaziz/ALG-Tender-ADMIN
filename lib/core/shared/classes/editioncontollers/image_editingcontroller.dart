import 'package:flutter/foundation.dart';
import 'package:tender_admin/core/shared/dto/imagedto/image.dto.dart';

class ImageEditingController extends ValueNotifier<ImageDTO?> {
  ImageEditingController([super._value]);

  void setImage(ImageDTO? image) => value = image;

  void removeImage() => value = null;
}
