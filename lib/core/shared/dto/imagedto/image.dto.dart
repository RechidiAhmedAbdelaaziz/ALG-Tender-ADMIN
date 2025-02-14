import 'dart:async';
import 'dart:html' as html;
import 'dart:io' as io;

import 'package:flutter/material.dart';
import 'package:tender_admin/core/di/locator.dart';
import 'package:tender_admin/core/services/cloudstorage/cloud_storage.service.dart';

part 'local_image.dto.dart';
part 'mobile_image.dto.dart';
part 'remote_image.dto.dart';
part 'web_image.dto.dart';

abstract class ImageDTO   {
  Future<ImageProvider> get image;

  Future<String> get imageUrl;

  
}

extension ImagesDtoMapper on List<ImageDTO> {
  Future<List<String>> get imageUrls async {
    return Future.wait(map((e) => e.imageUrl));
  }
}
