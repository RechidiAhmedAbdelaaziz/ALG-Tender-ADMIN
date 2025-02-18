part of 'source.dto.dart';

class CreateSourceDTO extends SourceDTO {
  CreateSourceDTO()
      : super(
          newsPaper: EditingController<NewsPaperModel>(),
          images: ListEditingcontroller<ImageDTO>(),
        );

  @override
  Future<Map<String, dynamic>> toMap() async {
    return {
      'newsPaper': _newsPaper.value!.id,
      'images': await _images.value.imageUrls,
    }.withoutNulls();
  }
}
