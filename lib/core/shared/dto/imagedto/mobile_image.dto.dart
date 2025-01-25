part of 'image.dto.dart';

class MobileImageDTO extends LocalImageDTO<io.File> {
  MobileImageDTO({required super.file});

  @override
  Future<ImageProvider> get image async => FileImage(file);

  @override
  Future<String> get imageUrl async => await _cloudStorageService.upload(file);
}
