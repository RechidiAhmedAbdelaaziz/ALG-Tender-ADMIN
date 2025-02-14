import 'package:tender_admin/core/di/locator.dart';
import 'package:tender_admin/core/network/repo_base.dart';
import 'package:tender_admin/core/network/types/api_result.type.dart';
import 'package:tender_admin/core/shared/dto/pagination/pagination.dto.dart';
import 'package:tender_admin/features/announcer/data/dto/announcer.dto.dart';
import 'package:tender_admin/features/announcer/data/models/announcer.model.dart';
import 'package:tender_admin/features/announcer/data/source/announcer.api.dart';

class AnnouncerRepo extends NetworkRepository {
  final _announcerApi = locator<AnnouncerApi>();

  RepoListResult<AnnouncerModel> getAnnouncers(
      PaginationDto dto) async {
    apicall() async {
      final response =
          await _announcerApi.getAnnouncers(dto.toJson());
      return PaginationResult.fromResponse(
          response: response, fromJson: AnnouncerModel.fromJson);
    }

    return tryApiCall(apicall);
  }

  RepoResult<AnnouncerModel> createAnnouncer(
      CreateAnnouncerDto dto) async {
    apicall() async {
      final response =
          await _announcerApi.createAnnouncer(await dto.toJson());
      return AnnouncerModel.fromJson(response.data!);
    }

    return tryApiCall(apicall);
  }

  RepoResult<AnnouncerModel> updateAnnouncer(
      UpdateAnnouncerDto dto) async {
    apicall() async {
      final response = await _announcerApi.updateAnnouncer(
        dto.model.id!,
        await dto.toJson(),
      );
      return AnnouncerModel.fromJson(response.data!);
    }

    return tryApiCall(apicall);
  }

  RepoResult<void> deleteAnnouncer(AnnouncerModel announcer) async {
    return tryApiCall(
        () => _announcerApi.deleteAnnouncer(announcer.id!));
  }
}
