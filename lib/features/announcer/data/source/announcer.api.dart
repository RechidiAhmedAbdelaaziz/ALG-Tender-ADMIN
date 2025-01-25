import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tender_admin/core/network/models/api_response.model.dart';

part 'announcer.api.g.dart';

@RestApi()
abstract class AnnouncerApi {
  factory AnnouncerApi(Dio dio, {String baseUrl}) = _AnnouncerApi;

  @GET('/announcer')
  Future<PaginatedDataResponse> getAnnouncers(
    @Queries() Map<String, dynamic> query,
  );

  @POST('/announcer')
  Future<DataResponse> createAnnouncer(
      @Body() Map<String, dynamic> body);

  @PATCH('/announcer/{id}')
  Future<DataResponse> updateAnnouncer(
    @Path('id') String id,
    @Body() Map<String, dynamic> body,
  );

  @DELETE('/announcer/{id}')
  Future<MessageResponse> deleteAnnouncer(@Path('id') String id);
}
