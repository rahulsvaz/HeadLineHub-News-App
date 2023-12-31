import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:webview_flutter/webview_flutter.dart';

class GitHubPage extends StatefulWidget {
  const GitHubPage({super.key});

  @override
  State<GitHubPage> createState() => _GitHubPageState();
}

class _GitHubPageState extends State<GitHubPage> {
 final controller = WebViewController()
  ..setJavaScriptMode(JavaScriptMode.unrestricted)
  ..setBackgroundColor(const Color(0x00000000))
  ..setNavigationDelegate(
  NavigationDelegate(
  onProgress: (int progress) {

    SpinKitPulse(
      color: Colors.grey,
    );
  },
  onPageStarted: (String url) {},
  onPageFinished: (String url) {},
  onWebResourceError: (WebResourceError error) {},
  onNavigationRequest: (NavigationRequest request) {
  if (request.url.startsWith('https://github.com/rahulsvaz')) {
  return NavigationDecision.prevent;
  }
  return NavigationDecision.navigate;
  },
  ),
  )
  ..loadRequest(Uri.parse('https://github.com/rahulsvaz'));
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:AppBar(title: Text('Github'),centerTitle: true,),
      body: SafeArea(child: WebViewWidget(controller: controller,)),
    );
  }
}
