import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdoven/markdown/atomcolor.dart';

class MarkdownStringBuilder extends StatelessWidget {
  final String string;
  final bool isdark;
  final bool ispage;
  const MarkdownStringBuilder(
      {required this.string,
      required this.ispage,
      this.isdark = false,
      super.key});

  MarkdownStyleSheet getTheme(BuildContext context) {
    Decoration blockDecoration = BoxDecoration(
        color: getContrastThemeColor(isdark: isdark),
        borderRadius: BorderRadius.circular((8)));
    TextStyle commonstyle = TextStyle(
        fontFamily: "default", color: getContrastThemeColor(isdark: isdark));
    return MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
      textScaleFactor: 2,
      h1: commonstyle,
      h2: commonstyle,
      h3: commonstyle,
      h4: commonstyle,
      h5: commonstyle,
      h6: commonstyle,
      a: commonstyle,
      p: commonstyle,
      horizontalRuleDecoration: blockDecoration,
      blockquoteDecoration: blockDecoration,
      codeblockDecoration: blockDecoration,
      code: commonstyle.copyWith(
          color: getThemeColor(isdark: isdark),
          backgroundColor: getContrastThemeColor(isdark: isdark)),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (ispage) {
      return Markdown(data: string, styleSheet: getTheme(context));
    } else {
      return Container(
        decoration: BoxDecoration(color: getThemeColor(isdark: isdark)),
        child: MarkdownBody(data: string, styleSheet: getTheme(context)),
      );
    }
  }
}
