import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class GithubScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text(
          "Eletcom",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: WebView(
          initialUrl: "https://admin-eletcom.vercel.app/",
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
