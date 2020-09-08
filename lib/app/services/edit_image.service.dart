import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:meu_querido_livro/app/utils/color_palette.dart';

class EditImageService {
  ColorPalette _colorPalette = ColorPalette();

  Future<File> editImage(File imageFile) async {
    File croppedFile = await ImageCropper.cropImage(
      sourcePath: imageFile.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9,
      ],
      androidUiSettings: AndroidUiSettings(
        toolbarTitle: 'Editar imagem',
        toolbarColor: _colorPalette.primaryColor,
        toolbarWidgetColor: _colorPalette.secondColor,
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: false,
      ),
      iosUiSettings: IOSUiSettings(
        minimumAspectRatio: 1.0,
      ),
    );
    return croppedFile;
  }
}
