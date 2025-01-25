part of 'cloudinary.service.dart';

class WebCloudinaryService extends CloudinaryService<html.File> {
  @override
  Future<void> _prepareRequest(html.File file) async {
    final reader = html.FileReader();
    final completer = Completer<List<int>>();
    reader.onLoadEnd.listen((_) {
      completer.complete(reader.result as List<int>);
    });
    reader.readAsArrayBuffer(file);
    final bytes = await completer.future;

    request.files.add(http.MultipartFile.fromBytes(
      'file',
      bytes,
      filename: file.name,
    ));
  }
}
