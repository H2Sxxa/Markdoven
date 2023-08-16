import 'package:flutter/material.dart';

const atomBlack = Color.fromRGBO(40, 44, 52, 1);
const atomWhite = Color.fromRGBO(220, 223, 228, 1);

Color getThemeColor({bool isdark = false}) {
  if (isdark) {
    return atomBlack;
  } else {
    return atomWhite;
  }
}

Color getContrastThemeColor({bool isdark = false}) {
  return getThemeColor(isdark: !isdark);
}
