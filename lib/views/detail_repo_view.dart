import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DetailRepoView extends StatefulWidget {
  final String url;
  const DetailRepoView({super.key, required this.url});

  @override
  State<DetailRepoView> createState() => _DetailRepoViewState();
}

class _DetailRepoViewState extends State<DetailRepoView> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted) // Allow JavaScript
      ..setBackgroundColor(const Color(0x00000000)) // Set background color (optional)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {},
          onPageFinished: (url) {},
          onWebResourceError: (error) {},
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Repo'),
      ),
      body: WebViewWidget(controller: _controller), // Use the WebViewWidget
    );
  }
}