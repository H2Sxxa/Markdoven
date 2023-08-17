import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:markdoven/api/httpsever.dart';
import 'package:markdoven/config/init.dart';
import 'package:markdoven/markdown/pagebuilder.dart';

final contentKey = GlobalKey();
final containerKey = GlobalKey();
void main() async {
  initConfig();
  initServer(readValue("host"), readValue("port"));
  runApp(const Application());
  doWhenWindowReady(() {
    final win = appWindow;
    const resize = Size(500, 500);
    win.size = resize;
    win.show();
  });
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'MarkDoven',
        home: ContentPage(
          key: containerKey,
        ),
        theme: ThemeData(fontFamily: "default"),
        darkTheme: ThemeData(
          fontFamily: "default",
        ));
  }
}

class ContentPage extends StatefulWidget {
  const ContentPage({super.key});

  @override
  State<ContentPage> createState() => ContentPageState();
}

class ContentPageState extends State<ContentPage> {
  String content = File("README.md").readAsStringSync();
  bool isdark = false;
  double textScale = 1;
  void renderText(String text, {bool isdark = false, double textScale = 1}) {
    setState(() {
      content = text;
      this.isdark = isdark;
      this.textScale = textScale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: RepaintBoundary(
      key: contentKey,
      child: MarkdownStringBuilder(
        string: content,
        isdark: isdark,
        textScale: textScale,
      ),
    ));
  }
}

ContentPageState getContentState() {
  return containerKey.currentState as ContentPageState;
}
