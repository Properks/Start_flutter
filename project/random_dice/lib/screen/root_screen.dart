import 'dart:math';

import 'package:flutter/material.dart';
import 'package:random_dice/screen/home_screen.dart';
import 'package:random_dice/screen/setting_screen.dart';
import 'package:shake/shake.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _RootScreenState();
  }
}

class _RootScreenState extends State<RootScreen> with TickerProviderStateMixin{ // Mixin 사용으로 불필요한 렌더링 감소
  TabController? tabController; // Controller 선언
  double threshold = 2.7;
  int number = 1;
  ShakeDetector? shakeDetector;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this); // Controller 초기화
    shakeDetector = ShakeDetector.autoStart(
      shakeSlopTimeMS: 100, // 흔들기 감지 시간 100: 100ms
      shakeThresholdGravity: threshold, // 흔들기 민감도
      onPhoneShake: onPhoneShake
    );
    // tabController!.addListener(tabListener);
  }

  void onPhoneShake() {
    final rand = Random();
    setState(() {
      number = rand.nextInt(5) + 1;
    });
  }


  tabListener() { // controller를 위한 listener
    setState(() {}); // build 함수를 재실행하기 위해 설정
  }

  @override
  void dispose() { // controller에 등록된 listener 삭제
    tabController!.removeListener(tabListener);
    shakeDetector!.stopListening();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: tabController,
        children: renderChildren(),
      ),
      bottomNavigationBar: renderBottomNavigation(),
    );
  }

  List<Widget> renderChildren() {
    return [
      HomeScreen(number: number),
      SettingScreen(
          threshold: threshold,
          onThresholdChanged: onThresholdChanged
      ),
    ];
  }

  BottomNavigationBar renderBottomNavigation() {
    // 아래의 네비게이션 바 설정
    return BottomNavigationBar(
      currentIndex: tabController!.index, // controller의 활성화된 탭을 현재 탭과 동기화
      onTap: (int index) { // 클릭한 index
        setState(() {
          tabController!.animateTo(index); // 해당 index의 TabBarView로 이동
        });
      },
      items: [
        // item을 순서대로 삽입
        BottomNavigationBarItem(
            icon: Icon( // 네비게이션 바에서 보여줄 icon 설정
              Icons.edgesensor_high_outlined
            ),
          label: "주사위", // icon 밑의 이름 설정
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.settings
          ),
          label: "설정",
        ),
      ]
    );
  }

  void onThresholdChanged(double val) {
    setState(() {
      threshold = val;
    });
  }
}