import 'package:flutter/material.dart';
import 'package:tender_admin/core/extension/map.extension.dart';
import 'package:tender_admin/core/shared/classes/editioncontollers/generic_editingcontroller.dart';
import 'package:tender_admin/core/shared/classes/editioncontollers/list_generic_editingcontroller.dart';
import 'package:tender_admin/core/shared/dto/pagination/pagination.dto.dart';
import 'package:tender_admin/features/announcer/data/models/announcer.model.dart';

class TenderFiltersDto extends PaginationDto {
  final EditingController<AnnouncerModel> announcer;
  final EditingController<DateTime> publishedAfter;
  final EditingController<DateTime> closingBefore;
  final TextEditingController marketType;
  final ListEditingcontroller<String> industries;
  final EditingController<bool> isStartup;
  final ListEditingcontroller<String> regions;

  TenderFiltersDto()
      : announcer = EditingController<AnnouncerModel>(),
        publishedAfter = EditingController<DateTime>(),
        closingBefore = EditingController<DateTime>(),
        marketType = TextEditingController(),
        industries = ListEditingcontroller<String>(),
        isStartup = EditingController<bool>(),
        regions = ListEditingcontroller<String>();

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json['announcer'] = announcer.value?.id;
    json['publishedAfter'] = publishedAfter.value?.toIso8601String();
    json['closingBefore'] = closingBefore.value?.toIso8601String();

    if (marketType.text.isNotEmpty) {
      json['marketType'] = marketType.text;
    }

    if (industries.value.isNotEmpty) {
      json['industries'] = industries.value;
    }

    if (isStartup.value == true) json['isStartup'] = isStartup.value;
    if (regions.value.isNotEmpty) json['regions'] = regions.value;
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

  void clear() {
    announcer.clear();
    publishedAfter.clear();
    closingBefore.clear();
    marketType.clear();
    industries.clear();
    isStartup.clear();
    regions.clear();
  }
}
