import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tender_admin/core/shared/classes/dimensions.dart';
import 'package:tender_admin/core/shared/module/images/singleimage/image.dart';
import 'package:tender_admin/core/shared/widgets/pages_indicator.dart';

import 'logic/images.cubit.dart';

class ImagesWidget extends StatefulWidget {
  final contrller = PageController(viewportFraction: 0.9);
  final Dimensions dimensions;

  ImagesWidget({super.key, required this.dimensions});

  @override
  State<ImagesWidget> createState() => _ImagesWidgetState();
}

class _ImagesWidgetState extends State<ImagesWidget> {
  @override
  void dispose() {
    widget.contrller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final imageCubits = context
        .select((ImagesCubit cubit) => cubit.state.imageCubits);
    return Center(
      child: SizedBox(
        width: widget.dimensions.width + 50.w,
        height: widget.dimensions.height + 120.h,
        child: Column(
          children: [
            IconButton(
              onPressed: () {
                context.read<ImagesCubit>().addImage();
              },
              icon: const Icon(Icons.add_a_photo),
            ),
            if (imageCubits.isNotEmpty) ...[
              //indicator
              PageIndicator(
                controller: widget.contrller,
                pageLength: imageCubits.length,
              ),
              heightSpace(5),
              Expanded(
                child: PageView(
                  controller: widget.contrller,
                  children: imageCubits
                      .map(
                        (imageCubit) => BlocProvider.value(
                          value: imageCubit,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              ImageWidget(
                                height: widget.dimensions.height,
                                width: widget.dimensions.width,
                                radius: widget.dimensions.radius,
                                canEdit: false,
                                onImageRemoved: () {
                                  context
                                      .read<ImagesCubit>()
                                      .removeImage(imageCubit);
                                },
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
