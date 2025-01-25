import 'package:flutter/material.dart';
import 'package:tender_admin/core/shared/classes/editioncontollers/number_editingcontroller.dart';

class PagiantionDto {
  final IntegerEditingController page;
  final IntegerEditingController limit;
  final TextEditingController keyword;
  final TextEditingController fields;
  final TextEditingController sort;

  PagiantionDto({
    int page = 1,
    int limit = 10,
    String? keyword,
    String? fields,
    String? sort,
  })  : keyword = TextEditingController(text: keyword),
        fields = TextEditingController(text: fields),
        sort = TextEditingController(text: sort),
        page = IntegerEditingController(page),
        limit = IntegerEditingController(limit);

  Map<String, dynamic> toJson() => {
        'page': page.value,
        'limit': limit.value,
        if (keyword.text.isNotEmpty) 'keyword': keyword.text,
        if (fields.text.isNotEmpty) 'fields': fields.text,
        if (sort.text.isNotEmpty) 'sort': sort.text,
      };

  void dispose() {
    page.dispose();
    limit.dispose();
    keyword.dispose();
    fields.dispose();
    sort.dispose();
  }
}
