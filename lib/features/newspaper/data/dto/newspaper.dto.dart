import 'package:flutter/material.dart';
import 'package:tender_admin/core/shared/classes/editioncontollers/image_editingcontroller.dart';
import 'package:tender_admin/core/shared/dto/imagedto/image.dto.dart';
import 'package:tender_admin/features/newspaper/data/models/newspaper.model.dart';

part 'create_newspaper.dto.dart';
part 'update_newspaper.dto.dart';

abstract class NewspaperDto {
  final TextEditingController name;
  final ImageEditingController image;

  NewspaperDto._({
    String? name,
    ImageDTO? image,
  })  : name = TextEditingController(text: name),
        image = ImageEditingController(image);

  Future<Map<String, dynamic>> toJson();

  void dispose() {
    name.dispose();
    image.dispose();
  }
}
