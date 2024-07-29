import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyWebView extends StatefulWidget {
  final String url;

  const MyWebView({super.key, required this.url});

  @override
  State<MyWebView> createState() => _MyWebViewState();
}

class _MyWebViewState extends State<MyWebView> {
  late final WebViewController controller;
  var LoadingPercentage = 0;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..loadRequest(Uri.parse(widget.url))
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) {
          setState(() {
            LoadingPercentage = 0;
          });
        },
        onProgress: (progress) {
          setState(() {
            LoadingPercentage = progress;
          });
        },
        onPageFinished: (url) {
          setState(() {
            LoadingPercentage = 100;
          });
        },
      ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("WebView"),
        actions: [
          Row(
            children: [
              IconButton(
                onPressed: () async {
                  final messenger = ScaffoldMessenger.of(context);
                  if (await controller.canGoBack()) {
                    await controller.goBack();
                  } else {
                    messenger.showSnackBar(
                      const SnackBar(
                        content: Text("No back history found"),
                      ),
                    );
                  }
                  return;
                },
                icon: const Icon(Icons.arrow_back_ios),
              ),
              IconButton(
                onPressed: () async {
                  final messenger = ScaffoldMessenger.of(context);
                  if (await controller.canGoForward()) {
                    await controller.goForward();
                  } else {
                    messenger.showSnackBar(
                      const SnackBar(
                        content: Text("No Forward history found"),
                      ),
                    );
                  }
                  return;
                },
                icon: const Icon(Icons.arrow_forward_ios),
              ),
              IconButton(
                onPressed: () {
                  controller.reload();
                },
                icon: const Icon(Icons.replay),
              )
            ],
          )
        ],
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: controller),
          if (LoadingPercentage < 100)
            LinearProgressIndicator(
              value: LoadingPercentage / 100.0,
            )
        ],
      ),
    );
  }
}
