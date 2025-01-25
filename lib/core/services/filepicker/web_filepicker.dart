part of 'filepick.service.dart';

class WebFilePicker extends FilePickerService<WebImageDTO> {
  @override
  Future<WebImageDTO?> pickFile() async {
    final input = html.FileUploadInputElement();
    input.accept = 'image/*';
    input.click();

    final completer = Completer<html.File?>();

    input.onChange.listen((event) {
      final files = input.files;
      if (files != null && files.isNotEmpty) {
        completer.complete(files.first);
      } else {
        completer.complete(null);
      }
    });

    final file = await completer.future;
    if (file != null) {
      return WebImageDTO(file: file);
    } else {
      throw Exception("No file picked");
    }
  }
}
