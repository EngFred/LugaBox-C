import 'dart:io';
import 'dart:math';

import 'package:image/image.dart';

void main() {
  Directory('assets/branding').createSync(recursive: true);
  _writeIcon('assets/branding/launcher_icon.png', 1024);
  _writeSplash('assets/branding/splash_logo.png', 1200, 420);
  _writeAndroid12Splash('assets/branding/android12_splash_icon.png', 960);
}

void _writeIcon(String path, int size) {
  final image = Image(width: size, height: size);
  fill(image, color: ColorRgb8(0, 0, 0));

  final inset = (size * .12).round();
  fillCircle(
    image,
    x: size ~/ 2,
    y: size ~/ 2,
    radius: (size * .38).round(),
    color: ColorRgb8(229, 9, 20),
  );
  fillCircle(
    image,
    x: size ~/ 2,
    y: size ~/ 2,
    radius: (size * .34).round(),
    color: ColorRgb8(17, 17, 17),
  );

  _drawLogoText(image, size, centerY: size ~/ 2, maxWidth: size - inset * 2);
  _drawArc(image, size, y: (size * .64).round(), width: (size * .55).round());

  File(path).writeAsBytesSync(encodePng(image));
}

void _writeSplash(String path, int width, int height) {
  final image = Image(width: width, height: height);
  fill(image, color: ColorRgb8(0, 0, 0));

  _drawLogoText(image, width, centerY: (height * .48).round(), maxWidth: 760);
  _drawArc(image, width, y: (height * .64).round(), width: 520);

  File(path).writeAsBytesSync(encodePng(image));
}

void _writeAndroid12Splash(String path, int size) {
  final image = Image(width: size, height: size);
  fill(image, color: ColorRgba8(0, 0, 0, 0));

  final center = size ~/ 2;
  final radius = (size * .25).round();
  fillCircle(
    image,
    x: center,
    y: center,
    radius: radius,
    color: ColorRgb8(17, 17, 17),
  );
  _drawCircleOutline(image, center, center, radius, ColorRgb8(229, 9, 20));
  _drawLogoText(image, size, centerY: center, maxWidth: (size * .40).round());
  _drawArc(image, size, y: (size * .57).round(), width: (size * .35).round());

  File(path).writeAsBytesSync(encodePng(image));
}

void _drawCircleOutline(Image image, int cx, int cy, int radius, Color color) {
  for (var angle = 0; angle < 360; angle++) {
    final radians = angle * pi / 180;
    for (var thickness = 0; thickness < 8; thickness++) {
      final x = cx + cos(radians) * (radius - thickness);
      final y = cy + sin(radians) * (radius - thickness);
      if (x >= 0 && x < image.width && y >= 0 && y < image.height) {
        image.setPixel(x.round(), y.round(), color);
      }
    }
  }
}

void _drawLogoText(
  Image image,
  int canvasWidth, {
  required int centerY,
  required int maxWidth,
}) {
  final font = arial48;
  const luga = 'Luga';
  const box = 'Box';
  final logoWidth = _measureText(font, luga + box);
  final scale = max(1, (maxWidth / logoWidth).floor());
  final width = logoWidth * scale;
  final x = (canvasWidth - width) ~/ 2;
  final y = centerY - (font.lineHeight * scale ~/ 2);

  _drawScaledText(image, luga, font, x, y, scale, ColorRgb8(255, 255, 255));
  _drawScaledText(
    image,
    box,
    font,
    x + _measureText(font, luga) * scale,
    y,
    scale,
    ColorRgb8(229, 9, 20),
  );
}

void _drawScaledText(
  Image image,
  String text,
  BitmapFont font,
  int x,
  int y,
  int scale,
  Color color,
) {
  final textImage = Image(
    width: _measureText(font, text),
    height: font.lineHeight,
  );
  fill(textImage, color: ColorRgba8(0, 0, 0, 0));
  drawString(textImage, text, font: font, x: 0, y: 0, color: color);
  final resized = copyResize(
    textImage,
    width: textImage.width * scale,
    height: textImage.height * scale,
    interpolation: Interpolation.nearest,
  );
  compositeImage(image, resized, dstX: x, dstY: y);
}

int _measureText(BitmapFont font, String text) {
  var width = 0;
  for (final char in text.codeUnits) {
    width += font.characters[char]?.xAdvance ?? font.base ~/ 2;
  }
  return width;
}

void _drawArc(
  Image image,
  int canvasWidth, {
  required int y,
  required int width,
}) {
  final startX = (canvasWidth - width) ~/ 2;
  for (var i = 0; i < width; i++) {
    final progress = i / width;
    final curve = sin(progress * pi);
    final py = y - (curve * 18).round();
    for (var thickness = 0; thickness < 6; thickness++) {
      image.setPixel(startX + i, py + thickness, ColorRgb8(229, 9, 20));
    }
  }
}
