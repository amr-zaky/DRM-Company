import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';

import '../../../presentation/widgets/take_photo_widget.dart';
import '../domain/model/image_class_model.dart';
import '/core/constants/app_constants.dart';
import '/core/feature/pick_multi_image/presentation/widgets/image_with_reomve_option.dart';
import '/core/helpers/shared.dart';
import '/core/helpers/shared_texts.dart';
import '/core/presentation/widgets/custom_snack_bar.dart';
import 'logic/pick_image_cubit.dart';
import 'logic/pick_image_status.dart';
import 'widgets/add_image_widget.dart';
import 'widgets/upload_image_widget.dart';

class PickImageWidget extends StatefulWidget {
  const PickImageWidget({
    Key? key,
    required this.images,
    required this.imageLength,
    required this.onSaveImage,
  }) : super(key: key);

  final List<ImageModel> images;
  final int imageLength;
  final Function(List<ImageModel>) onSaveImage;

  @override
  State<PickImageWidget> createState() => _PickImageWidgetState();
}

class _PickImageWidgetState extends State<PickImageWidget> {
  late PickImageCubit imageCubit;

  @override
  void initState() {
    super.initState();
    imageCubit = BlocProvider.of<PickImageCubit>(context);
    imageCubit.setSelectedImages(widget.images);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PickImageCubit, PickImageStatus>(
      listener: (BuildContext pickCtx, PickImageStatus pickState) {
        if (pickState is PickImageMaxReachStatus) {
          showSnackBar(
              context: context,
              title: AppLocalizations.of(context)!.lblMaxLengthReach,
              color: AppConstants.lightRedColor);
        } else if (pickState is PickImageUpdateStatus) {
          widget.onSaveImage(imageCubit.selectedImages);
        }
      },
      builder: (BuildContext pickCtx, PickImageStatus pickState) {
        return Column(
          children: <Widget>[
            if (widget.images.isNotEmpty) ...<Widget>[
              SizedBox(
                height: getWidgetHeight(80),
                width: SharedText.screenWidth,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(
                      vertical: getWidgetHeight(AppConstants.padding8)),
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    if (index == widget.images.length &&
                        widget.images.length < widget.imageLength) {
                      return InkWell(
                        onTap: () {
                          takePhotoBottomSheet(
                              context: context,
                              title: AppLocalizations.of(context)!.lblAddPic,
                              multiImage: true,
                              getPhoto: (XFile pickedImage) {
                                imageCubit.pickImageFroUser(
                                    pickedImage, widget.imageLength);
                              });
                        },
                        child: const AddImage(),
                      );
                    } else if (index == widget.imageLength) {
                      return const SizedBox.shrink();
                    } else {
                      return ImageWithRemoveOption(
                        isFile: widget.images[index].imageUrl == null,
                        imagePath: widget.images[index].imageUrl == null
                            ? widget.images[index].imageFile!
                            : widget.images[index].imageUrl!,
                        onRemoveClicked: () {
                          imageCubit.removeImageFromList(index: index);
                        },
                      );
                    }
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return getSpaceWidth(AppConstants.padding8);
                  },
                  itemCount: widget.images.length + 1,
                ),
              ),
            ] else ...<Widget>[
              UploadImageWidget(
                onImageClicked: () {
                  takePhotoBottomSheet(
                      context: context,
                      title: AppLocalizations.of(context)!.lblAddPic,
                      multiImage: true,
                      getPhoto: (XFile pickedImage) {
                        pickCtx
                            .read<PickImageCubit>()
                            .pickImageFroUser(pickedImage, widget.imageLength);
                      });
                },
              ),
            ],
          ],
        );
      },
    );
  }
}
