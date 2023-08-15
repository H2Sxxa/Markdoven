import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:markdoven/markdown/pagebuilder.dart';
import 'package:markdoven/markdown/render.dart';

final contentKey = GlobalKey();

void main() async {
  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'MarkDoven',
        home: const ContentPage(),
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
  State<ContentPage> createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      renderWidget(contentKey);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: RepaintBoundary(
      key: contentKey,
      child: const MarkdownStringBuilder(
        string: "# Markdown\n---\nHello, Here is MarkDoven!",
        ispage: false,
      ),
    ));
  }
}
