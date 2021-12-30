import 'package:flutter/material.dart';
import 'package:flutter_calendar_demo/constants.dart';
import 'dart:async';
import 'dart:io';

import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage({Key? key, required this.url}) : super(key: key);

  final String url;

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  double progress = 0;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkBlueColor,
        title: const Text('Client Profile'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          progress == 1.0
              ? Container()
              : LinearProgressIndicator(
                  value: progress,
                  color: lightOrangeColor,
                  backgroundColor: Colors.black,
                ),
          Expanded(
            child: WebView(
              initialUrl: widget.url,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
              },
              onProgress: (progress) => setState(() {
                this.progress = progress / 100;
              }),
            ),
          ),
        ],
      ),
    );
  }
}
