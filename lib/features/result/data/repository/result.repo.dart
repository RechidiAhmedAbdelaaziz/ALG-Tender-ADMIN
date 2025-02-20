import 'package:tender_admin/core/di/locator.dart';
import 'package:tender_admin/core/network/repo_base.dart';
import 'package:tender_admin/core/network/types/api_result.type.dart';
import 'package:tender_admin/core/shared/dto/pagination/pagination.dto.dart';
import 'package:tender_admin/features/result/data/dto/result.dto.dart';
import 'package:tender_admin/features/result/data/models/result.model.dart';

import '../source/result.api.dart';

class ResultRepo extends NetworkRepository {
  final _api = locator<ResultApi>();

  RepoListResult<ResultModel> getResults(PaginationDto dto) async {
    return tryApiCall(
      () async {
        final response = await _api.getResults(dto.toJson());
        return PaginationResult.fromResponse(
            response: response, fromJson: ResultModel.fromJson);
      },
    );
  }

  RepoResult<ResultModel> getResult(String id) async {
    return tryApiCall(() async {
      final response = await _api.getResult(id);
      return ResultModel.fromJson(response.data!);
    });
  }

  RepoResult<ResultModel> createResult(CreateResultDTO dto) async {
    return tryApiCall(() async {
      final response = await _api.createResult(await dto.toMap());
      return ResultModel.fromJson(response.data!);
    });
  }

  RepoResult<ResultModel> updateResult(UpdateResultDTO dto) async {
    return tryApiCall(() async {
      final body = await dto.toMap();
      final response = await _api.updateResult(dto.id, body);
      return ResultModel.fromJson(response.data!);
    });
  }

  RepoResult<void> deleteResult(ResultModel model) async {
    return tryApiCall(() async => await _api.deleteResult(model.id!));
  }
}
