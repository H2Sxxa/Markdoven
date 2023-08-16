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
  String content = "# Markdown\n---\nHello, Here is MarkDoven!";
  bool isdark = false;
  void renderText(String text, {bool isdark = false}) {
    setState(() {
      content = text;
      this.isdark = isdark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: RepaintBoundary(
      key: contentKey,
      child: MarkdownStringBuilder(
        string: content,
        ispage: false,
        isdark: isdark,
      ),
    ));
  }
}

ContentPageState getContentState() {
  return containerKey.currentState as ContentPageState;
}
