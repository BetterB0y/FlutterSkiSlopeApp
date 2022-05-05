import 'package:flutter/material.dart';
import 'package:ski_slope/widgets/ski_app_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SkiWebPage extends StatelessWidget {
  final String url;

  const SkiWebPage({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SkiAppBar(title: url),
      body: WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
