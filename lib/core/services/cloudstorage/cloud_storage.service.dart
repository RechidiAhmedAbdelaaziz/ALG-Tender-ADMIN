abstract class CloudStorageService<TFile> {
  /// Upload a file to the cloud storage 
  /// return the url of the uploaded file
  Future<String> upload(TFile file);
}
