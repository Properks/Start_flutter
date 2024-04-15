import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeScreen extends StatelessWidget {

  static final Uri _home = Uri.parse("https://blog.codefactory.ai");

  WebViewController webViewController = WebViewController()
  ..loadRequest(_home) // URI 불러오기
  ..setJavaScriptMode(JavaScriptMode.unrestricted); // 자바 스크립트가 제한없이 실행되도록 설정

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // 앱 상단의 AppBar 지정
      appBar: AppBar(
        // 배경색
        backgroundColor: Colors.orange,
        // 제목 설정
        title: const Text("Blog App"),
        // 제목 중앙 정렬
        centerTitle: true,

        // 오른쪽 끝부분에 놓는 위젯
        actions: [
          IconButton(
            onPressed: () {
              webViewController.loadRequest(_home);
            },
            icon: const Icon(Icons.home),
          ),
        ],
      ),
      body: WebViewWidget(
        controller: webViewController,
      ),
    );
  }
}