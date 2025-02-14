part of 'source.dto.dart';

class CreateSourceDTO extends SourceDTO {
  CreateSourceDTO()
      : super(
          newsPaper: Editingcontroller<NewsPaperModel>(),
          images: ListEditingcontroller<ImageDTO>(),
        );


  @override
  Future<Map<String, dynamic>> toMap() {
    return Future.value({
      'newsPaper': _newsPaper.value!.id,
      'images': _images.value.imageUrls,
    });
  }
}
