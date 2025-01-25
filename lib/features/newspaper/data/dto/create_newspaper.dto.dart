part of 'newspaper.dto.dart';

class CreateNewspaperDto extends NewspaperDto {
  CreateNewspaperDto() : super._();

  @override
  Future<Map<String, dynamic>> toJson() async {
    final imageUrl = await image.value?.imageUrl;
    return {
      'name': name.text,
      'imageUri': imageUrl,
    };
  }
}