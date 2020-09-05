import 'package:flutter/material.dart';
import 'package:meu_querido_livro/app/utils/color_palette.dart';

class SnackbarDefault {
  ColorPalette _colorPalette = ColorPalette();
  SnackbarDefault();

  SnackBar defaultMessage(String message) {
    return SnackBar(
      content: Text(message),
      backgroundColor: _colorPalette.primaryColor,
    );
  }

  SnackBar alertMessage(String message) {
    return SnackBar(
      content: Text(message),
      backgroundColor: _colorPalette.successColor,
    );
  }

  SnackBar successfulMessage(String message) {
    return SnackBar(
      content: Text(message),
      backgroundColor: _colorPalette.alertColor,
    );
  }
}
