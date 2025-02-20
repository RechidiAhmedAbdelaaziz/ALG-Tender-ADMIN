import 'package:flutter/widgets.dart';
import 'package:tender_admin/core/extension/map.extension.dart';
import 'package:tender_admin/core/shared/classes/editioncontollers/generic_editingcontroller.dart';
import 'package:tender_admin/core/shared/dto/pagination/pagination.dto.dart';

class ResultFiltersDto extends PaginationDto {
  final EditingController<DateTime> publishedAfter;
  final TextEditingController region;
  final TextEditingController type;
  final TextEditingController tenderId;

  ResultFiltersDto([String? tenderId])
      : publishedAfter = EditingController<DateTime>(),
        region = TextEditingController(),
        type = TextEditingController(),
        tenderId = TextEditingController(text: tenderId);

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json['publishedAfter'] = publishedAfter.value?.toIso8601String();
    json['region'] = region.text;
    json['type'] = type.text;
    json['tender'] = tenderId.text;
    return json.withoutNullsOrEmpty();
  }

  @override
  void dispose() {
    super.dispose();
    publishedAfter.dispose();
    region.dispose();
    type.dispose();
    tenderId.dispose();
  }
}
