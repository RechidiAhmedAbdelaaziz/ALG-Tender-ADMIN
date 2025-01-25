import 'package:tender_admin/core/di/locator.dart';
import 'package:tender_admin/core/network/models/api_response.model.dart';
import 'package:tender_admin/core/network/repo_base.dart';

import '../dto/login.dto.dart';
import '../sources/auth.api.dart';

class AuthRepo extends NetworkRepository {
  final _api = locator<AuthApi>();

  RepoResult<AuthTokens> login(LoginDto dto) async {
    apiCall() async {
      final response = await _api.login(dto.body);
      return response.tokens!;
    }

    return tryApiCall(apiCall);
  }

  RepoResult<AuthTokens> refreshToken(String refreshToken) async {
    apiCall() async {
      final response = await _api.refreshToken({
        'refreshToken': refreshToken,
      });

      return response.tokens!;
    }

    return tryApiCall(apiCall);
  }
}
