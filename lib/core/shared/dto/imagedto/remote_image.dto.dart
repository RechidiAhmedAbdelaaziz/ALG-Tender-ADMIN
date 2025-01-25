part of 'image.dto.dart';

class RemoteImageDTO extends ImageDTO {
  final String url;
  RemoteImageDTO({required this.url});

  @override
  Future<ImageProvider> get image async => NetworkImage(url);

  @override
  Future<String> get imageUrl async => url;
}
