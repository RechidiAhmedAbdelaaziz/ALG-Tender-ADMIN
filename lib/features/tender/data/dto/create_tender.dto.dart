part of 'tender.dto.dart';

class CreateTenderDTO extends TenderDto {
  CreateTenderDTO()
      : super._(
          title: TextEditingController(),
          announcer: Editingcontroller(),
          chargePrice: Editingcontroller(),
          closingDate: Editingcontroller(),
          industry: TextEditingController(),
          marketType: TextEditingController(),
          publishedDate: Editingcontroller(),
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
      'chargePrice': chargePrice.value,
      'industry': industry.text,
      'marketType': marketType.text,
      'region': region.text,
      'sources':
          await Future.wait(sources.value.map((e) => e.toMap())),
    }.withoutNulls();
  }
}
