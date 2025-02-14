import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tender_admin/features/announcer/data/models/announcer.model.dart';
import 'package:tender_admin/features/sources/data/models/source.model.dart';

part 'tender.model.g.dart';

@JsonSerializable(createToJson: false)
class TenderModel extends Equatable {
  const TenderModel({
    this.id,
    this.title,
    this.announcer,
    this.publishedDate,
    this.closingDate,
    this.chargePrice,
    this.marketType,
    this.industry,
    this.region,
    this.sources,
  });

  @JsonKey(name: '_id')
  final String? id;
  final String? title;
  final AnnouncerModel? announcer;
  final DateTime? publishedDate;
  final DateTime? closingDate;
  final num? chargePrice;
  final String? marketType;
  final String? industry;
  final String? region;
  final List<SourceModel>? sources;

  factory TenderModel.fromJson(Map<String, dynamic> json) =>
      _$TenderModelFromJson(json);

  @override
  List<Object?> get props => [id];
}
