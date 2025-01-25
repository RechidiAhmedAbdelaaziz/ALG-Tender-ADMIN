import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tender_admin/core/network/models/api_response.model.dart';

part 'newspaper.api.g.dart';

@RestApi()
abstract class NewsPaperApi {
  factory NewsPaperApi(Dio dio, {String baseUrl}) = _NewsPaperApi;

  @GET('/news-paper')
  Future<PaginatedDataResponse> getNewsPapers(
      @Queries() Map<String, dynamic> queries);

  @GET('/news-paper/{id}')
  Future<DataResponse> getNewsPaper(@Path('id') String id);

  @POST('/news-paper')
  Future<DataResponse> createNewsPaper(
      @Body() Map<String, dynamic> data);

  @PATCH('/news-paper/{id}')
  Future<DataResponse> updateNewsPaper(
      @Path('id') String id, @Body() Map<String, dynamic> data);

  @DELETE('/news-paper/{id}')
  Future<MessageResponse> deleteNewsPaper(@Path('id') String id);
}
