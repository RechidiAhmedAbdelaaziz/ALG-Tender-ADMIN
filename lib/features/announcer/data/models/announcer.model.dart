import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'announcer.model.g.dart';

@JsonSerializable(createToJson: false)
class AnnouncerModel extends Equatable {
  const AnnouncerModel({
    this.id,
    this.name,
    this.imageUri,
    this.isStartup,
  });

  @JsonKey(name: '_id')
  final String? id;

  final String? name;
  final String? imageUri;
  final bool? isStartup;

  factory AnnouncerModel.fromJson(Map<String, dynamic> json) =>
      _$AnnouncerModelFromJson(json);

  @override
  List<Object?> get props => [id];
}
