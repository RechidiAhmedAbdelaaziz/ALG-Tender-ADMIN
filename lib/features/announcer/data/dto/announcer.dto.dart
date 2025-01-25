import 'package:flutter/material.dart';
import 'package:tender_admin/core/shared/classes/editioncontollers/boolean_editigcontroller.dart';
import 'package:tender_admin/core/shared/classes/editioncontollers/image_editingcontroller.dart';
import 'package:tender_admin/core/shared/dto/imagedto/image.dto.dart';
import 'package:tender_admin/features/announcer/data/models/announcer.model.dart';

part 'create_announcer.dto.dart';
part 'update_announcer.dto.dart';

abstract class AnnouncerDto {
  final TextEditingController name;
  final ImageEditingController? image;
  final BooleanEditingController isStartup;

  AnnouncerDto({
    String? name,
    ImageDTO? image,
    bool isStartup = false,
  })  : name = TextEditingController(text: name),
        image = image != null ? ImageEditingController(image) : null,
        isStartup = BooleanEditingController(isStartup);

  Future<Map<String, dynamic>> toJson();
}
