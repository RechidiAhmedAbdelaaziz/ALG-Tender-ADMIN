
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tender_admin/core/network/models/api_response.model.dart';

part 'tender.api.g.dart';

@RestApi()
abstract class TenderApi {
  factory TenderApi(Dio dio, {String baseUrl}) = _TenderApi;

  @GET('/tender')
  Future<PaginatedDataResponse> getTenders(@Queries() Map<String, dynamic> queries);

  @GET('/tender/{id}')
  Future<DataResponse> getTender(@Path('id') String id);

  @POST('/tender')
  Future<DataResponse> createTender(@Body() Map<String, dynamic> data);

  @PATCH('/tender/{id}')
  Future<DataResponse> updateTender(@Path('id') String id, @Body() Map<String, dynamic> data);

  @DELETE('/tender/{id}')
  Future<MessageResponse> deleteTender(@Path('id') String id);
}