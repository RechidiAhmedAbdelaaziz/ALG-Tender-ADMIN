part of 'newspaper.dto.dart';

class UpdateNewspaperDto extends NewspaperDto {
  final NewsPaperModel model;

  UpdateNewspaperDto(
    this.model,
  ) : super._(
          name: model.name,
          image: RemoteImageDTO(url: model.imageUri ?? ''),
        );

  @override
  Future<Map<String, dynamic>> toJson() async {
    final imageUrl = await image.value?.imageUrl;

    return {
      if (name.text != model.name) 'name': name.text,
      if (imageUrl != model.imageUri) 'imageUri': imageUrl,
    };
  }
}
