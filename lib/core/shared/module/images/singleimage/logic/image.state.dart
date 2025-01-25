// ignore_for_file: library_private_types_in_public_api

part of 'image.cubit.dart';

enum _ImageState { initial, loading, loaded, ready, removed, error }

class ImageState extends Equatable {
  final ImageDTO? _imageDTO;
  final _ImageState _state;
  final String? error;

  const ImageState(
      {ImageDTO? imageDTO,
      _ImageState status = _ImageState.initial,
      this.error})
      : _imageDTO = imageDTO,
        _state = status;

  factory ImageState.initial([ImageDTO? imageDTO]) =>
      ImageState(imageDTO: imageDTO);

  ImageState _loading() => _copyWith(state: _ImageState.loading);

  ImageState _loaded(ImageDTO imageDTO) =>
      _copyWith(state: _ImageState.loaded, imageDTO: imageDTO);

  ImageState _ready(ImageProvider image) =>
      ReadyImageState(state: this, image: image);

  ImageState _removed() =>
      ImageState.initial()._copyWith(state: _ImageState.removed);

  ImageState _error(String error) =>
      _copyWith(state: _ImageState.error, error: error);

  ImageState _copyWith(
          {ImageDTO? imageDTO, _ImageState? state, String? error}) =>
      ImageState(
        imageDTO: imageDTO ?? _imageDTO,
        status: state ?? _state,
        error: error,
      );

  bool get isReady => _state == _ImageState.ready;
  bool get isPicked => _imageDTO != null;
  bool get isRemoved => _state == _ImageState.removed;
  ImageDTO get imageDTO => _imageDTO!;
  ImageProvider get image => (this as ReadyImageState)._image;

  @override
  List<Object?> get props => [_state, _imageDTO];
}

class ReadyImageState extends ImageState {
  final ImageProvider _image;

  ReadyImageState(
      {required ImageState state,
      required ImageProvider<Object> image})
      : _image = image,
        super(
          imageDTO: state._imageDTO,
          error: state.error,
          status: _ImageState.ready,
        );
}
