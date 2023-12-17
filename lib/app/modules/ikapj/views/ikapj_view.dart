import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

class IkapjView extends StatelessWidget {
  IkapjView({super.key});

  final _controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          debugPrint("Loading: $progress%");
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(Uri.parse("https://ikapj.or.id/"));

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: WebViewWidget(
          controller: _controller,
        ));
  }
}
