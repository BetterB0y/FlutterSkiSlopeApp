import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ski_slope/widgets/ski_app_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SkiWebPage extends StatefulWidget {
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
  State<SkiWebPage> createState() => _SkiWebPageState();
}

class _SkiWebPageState extends State<SkiWebPage> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SkiAppBar(
        title: widget.appBarTitle ?? widget.url,
        isGoogleAuth: widget.isGoogleAuth,
      ),
      body: Stack(
        children: [
          WebView(
            initialUrl: widget.url,
            userAgent: widget.userAgent,
            onPageFinished: (url) {
              setState(() => isLoading = false);
              if (widget.onPageFinished != null) {
                widget.onPageFinished!(url);
              }
            },
            javascriptMode: JavascriptMode.unrestricted,
            debuggingEnabled: kDebugMode,
            zoomEnabled: false,
          ),
          if (isLoading) const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
