import 'package:tender_admin/core/di/locator.dart';
import 'package:tender_admin/core/network/repo_base.dart';
import 'package:tender_admin/core/network/types/api_result.type.dart';
import 'package:tender_admin/core/shared/dto/pagination/pagination.dto.dart';
import 'package:tender_admin/features/newspaper/data/dto/newspaper.dto.dart';
import 'package:tender_admin/features/newspaper/data/models/newspaper.model.dart';
import 'package:tender_admin/features/newspaper/data/source/newspaper.api.dart';

class NewsPaperRepo extends NetworkRepository {
  final _api = locator<NewsPaperApi>();

  RepoListResult<NewsPaperModel> getNewsPapers(
      PaginationDto pagination) {
    return tryApiCall(
      () async {
        final response =
            await _api.getNewsPapers(pagination.toJson());
        return PaginationResult.fromResponse(
          response: response,
          fromJson: NewsPaperModel.fromJson,
        );
      },
    );
  }

  RepoResult<NewsPaperModel> createNewsPaper(CreateNewspaperDto dto) {
    return tryApiCall(
      () async {
        final response =
            await _api.createNewsPaper(await dto.toJson());
        return NewsPaperModel.fromJson(response.data!);
      },
    );
  }

  RepoResult<NewsPaperModel> updateNewsPaper(UpdateNewspaperDto dto) {
    return tryApiCall(
      () async {
        final response = await _api.updateNewsPaper(
          dto.model.id!,
          await dto.toJson(),
        );
        return NewsPaperModel.fromJson(response.data!);
      },
    );
  }

  RepoResult<void> deleteNewsPaper(NewsPaperModel model) {
    return tryApiCall(
      () async => await _api.deleteNewsPaper(model.id!),
    );
  }
}
