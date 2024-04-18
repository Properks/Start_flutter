import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Stateful widget
class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen>{
  final PageController pageController = PageController();

  @override
  void initState() {
    super.initState();

    Timer.periodic( // duration이 끝나면 뒤의 함수를 실행
      Duration(seconds: 3),
        (timer) {
          int? currentPage = pageController.page?.toInt();

          if (currentPage == null) {return;} // null인 상황 제외

          currentPage = (currentPage + 1) % 5;// 페이지 증가 후 마지막 페이지에서는 0으로 분기

          pageController.animateToPage(
              currentPage, // 이동할 위치
              duration: const Duration(milliseconds: 500), // 이동에 걸리는 시간
              curve: Curves.ease // 이동하는 방식
          );
          print("${currentPage + 1}번 째 페이지로 이동!");
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: [1, 2, 3, 4, 5]
        .map((number) =>
            Image.asset(
              "assets/img/image_$number.jpeg",
              fit: BoxFit.fill,
            ),
        ).toList(),
      ),
    );
  }
}