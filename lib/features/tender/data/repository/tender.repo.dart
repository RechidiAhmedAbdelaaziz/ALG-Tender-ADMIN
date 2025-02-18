import 'package:tender_admin/core/di/locator.dart';
import 'package:tender_admin/core/network/repo_base.dart';
import 'package:tender_admin/core/network/types/api_result.type.dart';
import 'package:tender_admin/core/shared/dto/pagination/pagination.dto.dart';
import 'package:tender_admin/features/tender/data/dto/tender.dto.dart';
import 'package:tender_admin/features/tender/data/models/tender.model.dart';
import 'package:tender_admin/features/tender/data/source/tender.api.dart';

class TenderRepo extends NetworkRepository {
  final _api = locator<TenderApi>();

  RepoListResult<TenderModel> getTenders(PaginationDto dto) async {
    return tryApiCall(
      () async {
        final response = await _api.getTenders(dto.toJson());
        return PaginationResult.fromResponse(
            response: response, fromJson: TenderModel.fromJson);
      },
    );
  }

  RepoResult<TenderModel> getTender(String id) async {
    return tryApiCall(() async {
      final response = await _api.getTender(id);
      return TenderModel.fromJson(response.data!);
    });
  }

  RepoResult<TenderModel> createTender(CreateTenderDTO dto) async {
    return tryApiCall(() async {
      final response = await _api.createTender(await dto.toMap());
      return TenderModel.fromJson(response.data!);
    });
  }

  RepoResult<TenderModel> updateTender(UpdateTenderDTO dto) async {
    return tryApiCall(() async {
    
      final body = await dto.toMap();
      final response = await _api.updateTender(dto.id, body);
      return TenderModel.fromJson(response.data!);
    });
  }

  RepoResult<void> deleteTender(TenderModel model) =>
      tryApiCall(() async => await _api.deleteTender(model.id!));
}
