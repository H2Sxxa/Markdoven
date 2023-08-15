import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void renderWidget(GlobalKey key) async {
  final boundary = key.currentContext?.findRenderObject();
  if (boundary != null && boundary is RenderRepaintBoundary) {
    final image = await boundary.toImage();
    ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
    if (byteData != null) {
      File("test.png").writeAsBytes(byteData.buffer.asUint8List());
    }
  }
}
