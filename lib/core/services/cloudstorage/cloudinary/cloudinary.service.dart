import 'dart:async';
import 'dart:convert';
import 'dart:html' as html;
import 'dart:io' as io;

import 'package:http/http.dart' as http;
import '../cloud_storage.service.dart';

part 'web_cloudinary.service.dart';
part 'mobile_cloudinary.service.dart';

abstract class CloudinaryService<TFile>
    extends CloudStorageService<TFile> {
  final String cloudName = "deljic9sr";
  final String apiKey = "248828733121325";
  final String apiSecret = "G2w253r_y0q7i7ardBnPA194Wjs";
  final String uploadPreset = 'learn_flutter';

  http.MultipartRequest get request {
    final url = Uri.parse(
        "https://api.cloudinary.com/v1_1/$cloudName/image/upload");

    // Prepare the data for the request
    return http.MultipartRequest("POST", url)
      ..fields['upload_preset'] = uploadPreset;
  }

  Future<void> _prepareRequest(TFile file);

  @override
  Future<String> upload(TFile file) async {
    await _prepareRequest(file);

    // Send the request
    final response =
        await http.Response.fromStream(await request.send());

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['secure_url']; // The URL of the uploaded image
    } else {
      throw Exception("Failed to upload image: ${response.body}");
    }
  }
}
