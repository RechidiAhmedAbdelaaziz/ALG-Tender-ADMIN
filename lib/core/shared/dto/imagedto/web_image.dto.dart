
part of 'image.dto.dart';

class WebImageDTO extends LocalImageDTO<html.File> {
  WebImageDTO({required super.file});

  @override
  Future<ImageProvider> get image async {
    final dataUrl = await _readFileAsDataUrl(file);
    return NetworkImage(dataUrl!);
  }

  Future<String?> _readFileAsDataUrl(html.File file) async {
    final reader = html.FileReader();
    final completer = Completer<String?>();

    reader.onLoadEnd.listen((event) {
      completer.complete(reader.result as String?);
    });

    reader.readAsDataUrl(
        file); // Reads the file as a Data URL (useful for images)
    return completer.future;
  }

  @override
  Future<String> get imageUrl async => await _cloudStorageService.upload(file);
}
