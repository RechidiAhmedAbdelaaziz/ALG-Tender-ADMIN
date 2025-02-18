part of 'tender.dto.dart';

class CreateTenderDTO extends TenderDto {
  CreateTenderDTO()
      : super._(
          title: TextEditingController(),
          announcer: EditingController(),
          chargePrice: TextEditingController(),
          closingDate: EditingController(),
          industry: TextEditingController(),
          marketType: TextEditingController(),
          publishedDate: EditingController(),
          region: TextEditingController(),
          sources: ListEditingcontroller(),
        );

  @override
  Future<Map<String, dynamic>> toMap() async {
    return {
      'title': title.text,
      'announcer': announcer.value?.id,
      'publishedDate': publishedDate.value?.toIso8601String(),
      'closingDate': closingDate.value?.toIso8601String(),
      'chargePrice': int.tryParse(chargePrice.text),
      'industry': industry.text,
      'marketType': marketType.text,
      'region': region.text,
      'sources': await Future.wait(
          sources.value.map((e) async => await e.toMap())),
    }.withoutNulls();
  }
}
