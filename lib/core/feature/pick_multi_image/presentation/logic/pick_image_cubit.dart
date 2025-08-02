import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../domain/model/image_class_model.dart';
import 'pick_image_status.dart';

class PickImageCubit extends Cubit<PickImageStatus> {
  PickImageCubit() : super(PickImageInitialStatus());

  static PickImageCubit get(BuildContext context) => BlocProvider.of(context);
  List<ImageModel> selectedImages = <ImageModel>[];

  void setSelectedImages(List<ImageModel> value) {
    selectedImages = value;
    emit(PickImageInitialStatus());
  }

  void pickImageFroUser(XFile xFile, int maxLength) {
    if (selectedImages.length == maxLength) {
      if (state is PickImageMaxReachStatus) {
        return;
      }
      emit(PickImageMaxReachStatus());
      return;
    } else {
      final ImageModel pickedImage = ImageModel(imageFile: xFile.path);
      selectedImages.add(pickedImage);
      emit(PickImageUpdateStatus());
    }
  }

  void removeImageFromList({required int index}) {
    selectedImages.removeAt(index);
    emit(PickImageUpdateStatus());
  }

  void clearPickedImage() {
    selectedImages.clear();
    emit(PickImageUpdateStatus());
  }
}
