part of 'announcer.dto.dart';

class UpdateAnnouncerDto extends AnnouncerDto {
  final AnnouncerModel model;

  UpdateAnnouncerDto(this.model)
      : super(
          name: model.name!,
          image: RemoteImageDTO(url: model.imageUri!),
          isStartup: model.isStartup!,
        );

  @override
  Future<Map<String, dynamic>> toJson() async {
    final imageUri = await image.value!.imageUrl;
    return {
      if (model.name != name.text) 'name': name.text,
      if (model.imageUri != imageUri) 'imageUri': imageUri,
      if (model.isStartup != isStartup.value)
        'isStartup': isStartup.value,
    };
  }
}
