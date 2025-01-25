import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tender_admin/core/shared/dto/imagedto/image.dto.dart';

import 'logic/image.cubit.dart';

class ImageWidget extends StatelessWidget {
  final double high;
  final double width;
  final double radius;
  final ImageDTO? imageDTO;

  final bool canEdit;
  final bool canRemove;

  final void Function(ImageDTO imageDto)? onImagePicked;
  final void Function()? onImageRemoved;

  const ImageWidget({
    super.key,
    required this.high,
    required this.width,
    required this.radius,
    this.onImagePicked,
    this.onImageRemoved,
    this.imageDTO,
    this.canEdit = true,
    this.canRemove = true,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<ImageCubit, ImageState>(
      listener: (context, state) {
        if (state.isReady) onImagePicked?.call(state.imageDTO);
        if (state.isRemoved) onImageRemoved?.call();
      },
      child:
          context.select((ImageCubit cubit) => cubit.state.isPicked)
              ? _Image(high, width, radius, canEdit, canRemove)
              : _ImagePicker(high, width, radius),
    );
  }
}

class _ImagePicker extends StatelessWidget {
  final double high;
  final double width;
  final double radius;

  const _ImagePicker(this.high, this.width, this.radius);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: high,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: Colors.grey.shade200,
      ),
      child: IconButton(
        icon: const Icon(Icons.add_a_photo),
        onPressed: () {
          context.read<ImageCubit>().pickImage();
        },
      ),
    );
  }
}

class _Image extends StatelessWidget {
  final double high;
  final double width;
  final double radius;
  final bool canEdit;
  final bool canRemove;
  const _Image(this.high, this.width, this.radius, this.canEdit,
      this.canRemove);

  @override
  Widget build(BuildContext context) {
    final isLoaded =
        context.select((ImageCubit cubit) => cubit.state.isReady);
    return isLoaded
        ? Column(
            children: [
              Container(
                height: high,
                width: width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radius),
                  image: DecorationImage(
                    image: context.read<ImageCubit>().state.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              if (canEdit || canRemove)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (canEdit)
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () =>
                            context.read<ImageCubit>().pickImage(),
                      ),
                    if (canRemove)
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () =>
                            context.read<ImageCubit>().removeImage(),
                      ),
                  ],
                ),
            ],
          )
        : const CircularProgressIndicator();
  }
}
