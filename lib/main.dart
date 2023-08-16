import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:markdoven/api/httpsever.dart';
import 'package:markdoven/markdown/pagebuilder.dart';
import 'package:markdoven/markdown/render.dart';

final contentKey = GlobalKey();
final containerKey = GlobalKey();
void main() async {
  initServer("127.0.0.1", 8089);
  runApp(const Application());
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
        theme: ThemeData(fontFamily: "default", brightness: Brightness.light),
        darkTheme: ThemeData(
          fontFamily: "default",
          brightness: Brightness.light,
        ));
  }
}

class ContentPage extends StatefulWidget {
  const ContentPage({super.key});

  @override
  State<ContentPage> createState() => ContentPageState();
}

class ContentPageState extends State<ContentPage> {
  String content = "# Markdown\n---\nHello, Here is MarkDoven!";

  Future<ByteData> renderText(String text) async {
    setState(() {
      content = text;
    });
    sleep(const Duration(seconds: 3));
    return await renderWidget(contentKey);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: RepaintBoundary(
      key: contentKey,
      child: MarkdownStringBuilder(
        string: content,
        ispage: false,
      ),
    ));
  }
}

ContentPageState getContentState() {
  return containerKey.currentState as ContentPageState;
}
