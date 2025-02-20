import 'package:flutter/widgets.dart';
import 'package:tender_admin/core/extension/map.extension.dart';
import 'package:tender_admin/core/shared/classes/editioncontollers/generic_editingcontroller.dart';
import 'package:tender_admin/core/shared/classes/editioncontollers/list_generic_editingcontroller.dart';
import 'package:tender_admin/core/shared/dto/create_update.dto.dart';
import 'package:tender_admin/features/result/data/models/result.model.dart';
import 'package:tender_admin/features/sources/data/dto/source.dto.dart';
import 'package:tender_admin/features/tender/data/models/tender.model.dart';

part 'create_result.dto.dart';
part 'update_result.dto.dart';

abstract class ResultDTO extends CreateUpdateDto {
  final EditingController<DateTime> publishedDate;
  final TextEditingController region;
  final EditingController<TenderModel> tender;
  final TextEditingController type;
  final TextEditingController title;
  final ListEditingcontroller<SourceDTO> sources;

  ResultDTO._({
    required this.publishedDate,
    required this.region,
    required this.tender,
    required this.type,
    required this.title,
    required this.sources,
  });

  String get tenderId => tender.value!.id!;

  @override
  void dispose() {
    publishedDate.dispose();
    region.dispose();
    tender.dispose();
    type.dispose();
    title.dispose();
    sources.dispose();
  }
}
