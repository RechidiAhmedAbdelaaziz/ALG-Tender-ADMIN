part of 'source.dto.dart';

class UpdateSourceDto extends SourceDTO {
  final SourceModel source;

  UpdateSourceDto(this.source)
      : super(
          newsPaper:
              EditingController<NewsPaperModel>(source.newspaper),
          images:
              ListEditingcontroller<ImageDTO>(source.images ?? []),
        );

  factory UpdateSourceDto.empty() => UpdateSourceDto(SourceModel());
  @override
  Future<Map<String, dynamic>> toMap() async {
    final urls = await _images.value.imageUrls;
    final sourceUrls = await (source.images ?? []).imageUrls;

    final imagesToDelete = sourceUrls
        .where((element) => !urls.contains(element))
        .toList();

    final imagesToAdd = urls
        .where((element) => !sourceUrls.contains(element))
        .toList();

    return imagesToAdd.isEmpty && imagesToDelete.isEmpty
        ? {}
        : {
            'newsPaper': newsPaper!.id,
            'imagesToAdd': imagesToAdd,
            'imagesToRemove': imagesToDelete,
          };
  }
}
