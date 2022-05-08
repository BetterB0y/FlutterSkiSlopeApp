import 'package:flutter/material.dart';
import 'package:ski_slope/widgets/ski_app_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SkiWebPage extends StatelessWidget {
  final String url;
  final String? appBarTitle;
  final String? userAgent;
  final Function(String)? onPageFinished;
  final bool isGoogleAuth;

  const SkiWebPage({
    Key? key,
    required this.url,
    this.appBarTitle,
    this.userAgent,
    this.onPageFinished,
    this.isGoogleAuth = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SkiAppBar(
        title: appBarTitle ?? url,
        isGoogleAuth: isGoogleAuth,
      ),
      body: WebView(
        initialUrl: url,
        userAgent: userAgent,
        onPageFinished: onPageFinished,
        javascriptMode: JavascriptMode.unrestricted,
        zoomEnabled: false,
      ),
    );
  }
}
