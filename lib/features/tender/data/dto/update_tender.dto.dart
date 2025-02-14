part of 'tender.dto.dart';

class UpdateTenderDTO extends TenderDto {
  final TenderModel _tender;
  UpdateTenderDTO(this._tender)
      : super._(
          title: TextEditingController(text: _tender.title),
          announcer: Editingcontroller(_tender.announcer),
          chargePrice: Editingcontroller(_tender.chargePrice),
          closingDate: Editingcontroller(_tender.closingDate),
          industry: TextEditingController(text: _tender.industry),
          marketType: TextEditingController(text: _tender.marketType),
          publishedDate: Editingcontroller(_tender.publishedDate),
          region: TextEditingController(text: _tender.region),
          sources: ListEditingcontroller(
            _tender.sources
                    ?.map((e) => UpdateSourceDto(e))
                    .toList() ??
                [],
          ),
        );

  @override
  Future<Map<String, dynamic>> toMap() async {
    return {
      if (title.text != _tender.title) 'title': title.text,
      if (announcer.value?.id != _tender.announcer?.id)
        'announcer': announcer.value?.id,
      if (publishedDate.value != _tender.publishedDate)
        'publishedDate': publishedDate.value?.toIso8601String(),
      if (closingDate.value != _tender.closingDate)
        'closingDate': closingDate.value?.toIso8601String(),
      if (chargePrice.value != _tender.chargePrice)
        'chargePrice': chargePrice.value,
      if (industry.text != _tender.industry)
        'industry': industry.text,
      if (marketType.text != _tender.marketType)
        'marketType': marketType.text,
      if (region.text != _tender.region) 'region': region.text,
      if (sources.value.isNotEmpty)
        'sources': await Future.wait(
          sources.value
              .whereType<UpdateSourceDto>()
              .map((e) => e.toMap()),
        ),
    }.withoutNulls();
  }
}
