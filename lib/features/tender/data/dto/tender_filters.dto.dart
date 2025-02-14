import 'package:flutter/material.dart';
import 'package:tender_admin/core/extension/map.extension.dart';
import 'package:tender_admin/core/shared/classes/editioncontollers/generic_editingcontroller.dart';
import 'package:tender_admin/core/shared/dto/pagination/pagination.dto.dart';
import 'package:tender_admin/features/announcer/data/models/announcer.model.dart';

class TenderFiltersDto extends PaginationDto {
  final Editingcontroller<AnnouncerModel> announcer;
  final Editingcontroller<DateTime> publishedAfter;
  final Editingcontroller<DateTime> closingBefore;
  final TextEditingController marketType;
  final Editingcontroller<String> industries;
  final Editingcontroller<bool> isStartup;
  final Editingcontroller<String> regions;

  TenderFiltersDto()
      : announcer = Editingcontroller<AnnouncerModel>(),
        publishedAfter = Editingcontroller<DateTime>(),
        closingBefore = Editingcontroller<DateTime>(),
        marketType = TextEditingController(),
        industries = Editingcontroller<String>(),
        isStartup = Editingcontroller<bool>(),
        regions = Editingcontroller<String>();

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json['announcer'] = announcer.value?.id;
    json['publishedAfter'] = publishedAfter.value?.toIso8601String();
    json['closingBefore'] = closingBefore.value?.toIso8601String();
    json['marketType'] = marketType.text;
    json['industries'] = industries.value;
    json['isStartup'] = isStartup.value;
    json['regions'] = regions.value;
    return json.withoutNulls();
  }

  @override
  void dispose() {
    announcer.dispose();
    publishedAfter.dispose();
    closingBefore.dispose();
    marketType.dispose();
    industries.dispose();
    isStartup.dispose();
    regions.dispose();
    super.dispose();
  }
}
