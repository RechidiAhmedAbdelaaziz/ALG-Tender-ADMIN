import 'package:tender_admin/core/shared/classes/editioncontollers/generic_editingcontroller.dart';
import 'package:tender_admin/core/shared/classes/editioncontollers/list_generic_editingcontroller.dart';
import 'package:tender_admin/core/shared/dto/create_update.dto.dart';
import 'package:tender_admin/core/shared/dto/imagedto/image.dto.dart';
import 'package:tender_admin/features/newspaper/data/models/newspaper.model.dart';

import '../models/source.model.dart';

part 'update_source.dto.dart';
part 'create_source.dto.dart';

abstract class SourceDTO extends CreateUpdateDto {
  final Editingcontroller<NewsPaperModel> _newsPaper;
  final ListEditingcontroller<ImageDTO> _images;

  SourceDTO({
    required Editingcontroller<NewsPaperModel> newsPaper,
    required ListEditingcontroller<ImageDTO> images,
  })  : _images = images,
        _newsPaper = newsPaper;

  NewsPaperModel? get newsPaper => _newsPaper.value;
  List<ImageDTO> get images => _images.value;

  void updateImages(List<ImageDTO> images) => _images.value = images;
  void updateNewsPaper(NewsPaperModel newsPaper) => _newsPaper.value = newsPaper;

  @override
  void dispose() {
    _newsPaper.dispose();
    _images.dispose();
  }

  @override
  List<Object?> get props => [_newsPaper.value];

 
}
