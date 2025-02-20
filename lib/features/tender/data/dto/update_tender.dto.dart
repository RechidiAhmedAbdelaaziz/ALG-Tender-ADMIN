part of 'tender.dto.dart';

class UpdateTenderDTO extends TenderDto {
  final TenderModel _tender;
  UpdateTenderDTO(this._tender)
      : super._(
          title: TextEditingController(text: _tender.title),
          announcer: EditingController(_tender.announcer),
          chargePrice: TextEditingController(
              text: _tender.chargePrice?.toString()),
          closingDate: EditingController(_tender.closingDate),
          industry: TextEditingController(text: _tender.industry),
          marketType: TextEditingController(text: _tender.marketType),
          publishedDate: EditingController(_tender.publishedDate),
          region: TextEditingController(text: _tender.region),
          sources: ListEditingcontroller(
            _tender.sources
                    ?.map((e) => UpdateSourceDto(e))
                    .toList() ??
                [],
          ),
        );

  String get id {
    return _tender.id!;
  }

  @override
  Future<Map<String, dynamic>> toMap() async {
    final json = {
      if (title.text != _tender.title) 'title': title.text,
      if (announcer.value?.id != _tender.announcer?.id)
        'announcer': announcer.value?.id,
      if (publishedDate.value != _tender.publishedDate)
        'publishedDate': publishedDate.value?.toIso8601String(),
      if (closingDate.value != _tender.closingDate)
        'closingDate': closingDate.value?.toIso8601String(),
      if (chargePrice.text != _tender.chargePrice?.toString())
        'chargePrice': int.tryParse(chargePrice.text),
      if (industry.text != _tender.industry)
        'industry': industry.text,
      if (marketType.text != _tender.marketType)
        'marketType': marketType.text,
      if (region.text != _tender.region) 'region': region.text,
      if (sources.value.isNotEmpty)
        'sources': await Future.wait(
          sources.value.whereType<UpdateSourceDto>().map((e) {
            return e.toMap();
          }),
        ),
    }.withoutNullsOrEmpty();

    (json['sources'] as List<dynamic>)
        .removeWhere((value) => value['newsPaper'] == null);
    if ((json['sources'] as List<dynamic>).isEmpty) {
      json.remove('sources');
    }

    return json;
  }
}
