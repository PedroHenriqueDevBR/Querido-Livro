import 'dart:io';

import 'package:image_picker/image_picker.dart';

class GetImageService {
  ImagePicker _imagePicker = ImagePicker();

  Future<File> getImageFromCamera() async {
    File image;
    PickedFile picketImage = await _imagePicker.getImage(source: ImageSource.camera);
    image = File(picketImage.path);
    return image;
  }

  Future<File> getImageFromGallery() async {
    File image;
    PickedFile picketImage = await _imagePicker.getImage(source: ImageSource.gallery);
    image = File(picketImage.path);
    return image;
  }
}
