import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tender_admin/core/network/models/api_response.model.dart';

part 'result.api.g.dart';

@RestApi()
abstract class ResultApi {
  factory ResultApi(Dio dio, {String baseUrl}) = _ResultApi;

  @GET('/tender-result')
  Future<PaginatedDataResponse> getResults(
      @Queries() Map<String, dynamic> queries);

  @GET('/tender-result/{id}')
  Future<DataResponse> getResult(@Path('id') String id);

  @POST('/tender-result')
  Future<DataResponse> createResult(
      @Body() Map<String, dynamic> data);

  @PATCH('/tender-result/{id}')
  Future<DataResponse> updateResult(
      @Path('id') String id, @Body() Map<String, dynamic> data);

  @DELETE('/tender-result/{id}')
  Future<MessageResponse> deleteResult(@Path('id') String id);
}
