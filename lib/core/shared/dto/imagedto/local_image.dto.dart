part of 'image.dto.dart';

abstract class LocalImageDTO<TFile> extends ImageDTO {
  final TFile file;
  final _cloudStorageService = locator<CloudStorageService>();
  LocalImageDTO({required this.file});

  @override
  Future<ImageProvider> get image;

  @override
  Future<String> get imageUrl;
}
