import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tender_admin/core/network/models/api_response.model.dart';

part 'auth.api.g.dart';

@RestApi()
abstract class AuthApi {
  factory AuthApi(Dio dio, {String baseUrl}) = _AuthApi;

  @POST('/auth/login')
  Future<AuthResponse> login(@Body() Map<String, dynamic> body);

  @GET('/auth/refresh-token')
  Future<AuthResponse> refreshToken(
      @Queries() Map<String, dynamic> queries);
}
