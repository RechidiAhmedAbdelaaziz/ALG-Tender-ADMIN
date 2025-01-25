part of 'cloudinary.service.dart';

class MobileCloudinaryService extends CloudinaryService<io.File> {
  @override
  Future<void> _prepareRequest(io.File file) async {
    request.files.add(
      await http.MultipartFile.fromPath('file', file.path),
    );
  }
}
