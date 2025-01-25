import 'package:json_annotation/json_annotation.dart';

part 'newspaper.model.g.dart';

@JsonSerializable(createToJson: false)
class NewsPaperModel {
  NewsPaperModel({
    this.id,
    this.name,
    this.imageUri,
  });

  @JsonKey(name: '_id')
  final String? id;
  final String? name;
  final String? imageUri;

  factory NewsPaperModel.fromJson(Map<String, dynamic> json) =>
      _$NewsPaperModelFromJson(json);
}
