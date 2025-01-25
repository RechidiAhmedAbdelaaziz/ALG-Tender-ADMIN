part of 'announcer.dto.dart';

class CreateAnnouncerDto extends AnnouncerDto {
  CreateAnnouncerDto();

  @override
  Future<Map<String, dynamic>> toJson() async {
    return {
      'name': name.text,
      'image': await image!.value!.imageUrl,
      'isStartup': isStartup.value,
    };
  }
}
