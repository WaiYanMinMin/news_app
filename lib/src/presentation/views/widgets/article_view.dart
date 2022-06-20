// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../screens/homepage.dart';

class ArticleView extends StatefulWidget {
  final String postUrl;
  const ArticleView({
    Key? key,
    required this.postUrl,
  }) : super(key: key);

  @override
  ArticleViewState createState() => ArticleViewState();
}

class ArticleViewState extends State<ArticleView> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.red,
          elevation: 0,
          centerTitle: true,
          title:const  Text('News')),
      drawer: const DrawerBody(),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: WebView(
          initialUrl: widget.postUrl,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
        ),
      ),
    );
  }
}
