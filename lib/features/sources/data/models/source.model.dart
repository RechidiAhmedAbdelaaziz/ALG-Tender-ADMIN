import 'package:equatable/equatable.dart';
import 'package:tender_admin/core/shared/dto/imagedto/image.dto.dart';
import 'package:tender_admin/features/newspaper/data/models/newspaper.model.dart';
import 'package:tender_admin/features/sources/data/dto/source.dto.dart';

class SourceModel extends Equatable {
  const SourceModel({
    this.newspaper,
    this.images,
  });

  final NewsPaperModel? newspaper;
  final List<ImageDTO>? images;

  factory SourceModel.fromJson(Map<String, dynamic> json) {
    return SourceModel(
      newspaper: json['newspaper'] != null
          ? NewsPaperModel.fromJson(json['newspaper'])
          : null,
      images: json['images'] != null
          ? (json['images'] as List<String>)
              .map((e) => RemoteImageDTO(url: e))
              .toList()
          : null,
    );
  }

  factory SourceModel.fromDTO(SourceDTO dto) {
    return SourceModel(
      newspaper: dto.newsPaper,
      images: dto.images,
    );
  }

  @override
  List<Object?> get props => [newspaper];
}
