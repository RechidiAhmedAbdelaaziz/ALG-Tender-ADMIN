part of 'result.dto.dart';

class CreateResultDTO extends ResultDTO {
  CreateResultDTO()
      : super._(
          publishedDate: EditingController(DateTime.now()),
          region: TextEditingController(),
          tender: EditingController(),
          type: TextEditingController(),
          title: TextEditingController(),
          sources: ListEditingcontroller(),
        );

  @override
  Future<Map<String, dynamic>> toMap()async{
    return {
      'publishedDate': publishedDate.value?.toIso8601String(),
      'region': region.text,
      'tender': tender.value?.id,
      'type': type.text,
      'title': title.text,
      'sources': await Future.wait(
        sources.value.whereType<CreateSourceDTO>().map((e) {
          return e.toMap();
        }),
      ),
    }.withoutNullsOrEmpty();
    
  }
}
