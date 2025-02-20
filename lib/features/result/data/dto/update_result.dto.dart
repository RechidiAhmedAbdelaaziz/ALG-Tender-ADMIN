part of 'result.dto.dart';

class UpdateResultDTO extends ResultDTO {
  final ResultModel _result;

  UpdateResultDTO(this._result)
      : super._(
          publishedDate: EditingController(_result.publishedDate),
          region: TextEditingController(text: _result.region),
          tender: EditingController(_result.tender),
          type: TextEditingController(text: _result.type),
          title: TextEditingController(text: _result.title),
          sources: ListEditingcontroller(
            _result.sources
                    ?.map((e) => UpdateSourceDto(e))
                    .toList() ??
                [],
          ),
        );

  String get id => _result.id!;

  @override
  Future<Map<String, dynamic>> toMap() async {
    final json = {
      if (publishedDate.value != _result.publishedDate)
        'publishedDate': publishedDate.value?.toIso8601String(),
      if (region.text != _result.region) 'region': region.text,
      if (tender.value?.id != _result.tender?.id)
        'tender': tender.value?.id,
      if (type.text != _result.type) 'type': type.text,
      if (title.text != _result.title) 'title': title.text,
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
