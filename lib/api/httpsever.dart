import 'package:belatuk_http_server/belatuk_http_server.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:markdoven/main.dart';
import 'package:markdoven/markdown/render.dart';

void initServer(String ip, int port) async {
  var server = await HttpServer.bind(ip, port);
  server.transform(HttpBodyHandler()).listen((event) async {
    switch (event.request.method) {
      case "GET":
        handleGet(event.request);
        break;
      case "POST":
        handlePost(event.request, event.body);
        break;
      default:
        event.request.response.write("unsupport method");
        break;
    }
  });
}

Future<void> handleGet(HttpRequest event) async {
  switch (event.uri.toString()) {
    case "/api/screenshot":
      event.response.add((await renderWidget(contentKey)).buffer.asUint8List());
      await event.response.flush();
      await event.response.close();
    default:
      break;
  }
}

void handlePost(HttpRequest event, dynamic body) async {
  switch (event.uri.toString()) {
    case "/api/generate":
      String text = getValueElse(body, "text", "# No 'text' argument");
      bool isdark = getValueElse(body, "isdark", false);
      double width = getValueElse(body, "width", 500).toDouble();
      double scale = getValueElse(body, "scale", 1).toDouble();

      doWhenWindowReady(() {
        final win = appWindow;
        final resize = Size(width, 500);
        win.size = resize;
        win.show();
      });

      getContentState().renderText(text, isdark: isdark, textScale: scale);
      await event.response.flush();
      await event.response.close();
      break;
    default:
      break;
  }
}

void switchtoImage(HttpRequest event) {
  event.response.headers.contentType =
      ContentType("image", "png", charset: "utf-8");
}

void switchtoJson(HttpRequest event) {
  event.response.headers.contentType =
      ContentType("application", "json", charset: "utf-8");
}

dynamic getValueElse(
    Map<String, dynamic> jsonmap, String key, dynamic elsevalue) {
  if (jsonmap.containsKey(key)) {
    return jsonmap[key];
  }
  return elsevalue;
}
