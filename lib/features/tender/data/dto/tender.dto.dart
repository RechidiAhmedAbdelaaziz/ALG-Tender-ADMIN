import 'package:flutter/material.dart';
import 'package:tender_admin/core/extension/map.extension.dart';
import 'package:tender_admin/core/shared/classes/editioncontollers/generic_editingcontroller.dart';
import 'package:tender_admin/core/shared/classes/editioncontollers/list_generic_editingcontroller.dart';
import 'package:tender_admin/core/shared/dto/create_update.dto.dart';
import 'package:tender_admin/features/announcer/data/models/announcer.model.dart';
import 'package:tender_admin/features/sources/data/dto/source.dto.dart';
import 'package:tender_admin/features/tender/data/models/tender.model.dart';

part 'create_tender.dto.dart';
part 'update_tender.dto.dart';

abstract class TenderDto extends CreateUpdateDto {
  final TextEditingController title;
  final EditingController<AnnouncerModel> announcer;
  final EditingController<DateTime> publishedDate;
  final EditingController<DateTime> closingDate;
  final TextEditingController chargePrice;
  final TextEditingController industry;
  final TextEditingController marketType;
  final TextEditingController region;
  final ListEditingcontroller<SourceDTO> sources;

  TenderDto._(
      {required this.title,
      required this.announcer,
      required this.publishedDate,
      required this.closingDate,
      required this.chargePrice,
      required this.industry,
      required this.marketType,
      required this.region,
      required this.sources});

  @override
  void dispose() {
    title.dispose();
    announcer.dispose();
    publishedDate.dispose();
    closingDate.dispose();
    chargePrice.dispose();
    industry.dispose();
    marketType.dispose();
    region.dispose();
    sources.dispose();
  }
}
