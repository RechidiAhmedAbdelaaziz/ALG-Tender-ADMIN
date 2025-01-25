part of 'images.cubit.dart';

class ImagesState extends Equatable {
  final List<ImageCubit> imageCubits;

  const ImagesState({required this.imageCubits});

  factory ImagesState.initial([List<ImageDTO>? images]) =>
      ImagesState(
        imageCubits: images?.map((e) => ImageCubit(e)).toList() ?? [],
      );

  ImagesState _addImage() {
    final image = ImageCubit()..pickImage();
    return _copyWith(images: [...imageCubits, image]);
  }

  ImagesState _removeImage(ImageCubit image) {
    final newImages =
        imageCubits.where((element) => element != image).toList();
    image.close();
    return _copyWith(images: newImages);
  }

  ImagesState _copyWith({List<ImageCubit>? images}) =>
      ImagesState(imageCubits: images ?? imageCubits);

  List<ImageDTO> get images =>
      imageCubits.map((e) => e.state.imageDTO).toList();

  @override
  List<Object?> get props => [imageCubits.length];
}
