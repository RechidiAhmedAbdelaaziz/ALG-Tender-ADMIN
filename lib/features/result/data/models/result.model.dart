import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tender_admin/features/sources/data/models/source.model.dart';
import 'package:tender_admin/features/tender/data/models/tender.model.dart';

part 'result.model.g.dart';

@JsonSerializable(createToJson: false)
class ResultModel extends Equatable {
  const ResultModel({
    this.id,
    this.title,
    this.publishedDate,
    this.type,
    this.region,
    this.tender,
    this.sources,
  });

  @JsonKey(name: '_id')
  final String? id;
  final String? title;
  final DateTime? publishedDate;
  final String? type;
  final String? region;
  final TenderModel? tender;
  final List<SourceModel>? sources;

  factory ResultModel.fromJson(Map<String, dynamic> json) =>
      _$ResultModelFromJson(json);

  @override
  List<Object?> get props => [id];
}
