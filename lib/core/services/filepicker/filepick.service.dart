import 'dart:async';
import 'dart:html' as html;
import 'package:tender_admin/core/shared/dto/imagedto/image.dto.dart';

part 'web_filepicker.dart';

abstract class FilePickerService<T extends LocalImageDTO> {
  Future<T?> pickFile();
}
