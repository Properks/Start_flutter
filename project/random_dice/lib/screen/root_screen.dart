import 'package:flutter/material.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _RootScreenState();
  }
}

class _RootScreenState extends State<RootScreen> with TickerProviderStateMixin{ // Mixin 사용으로 불필요한 렌더링 감소
  TabController? tabController; // Controller 선언

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this); // Controller 초기화
    // tabController!.addListener(tabListener);
  }


  // tabListener() { // controller를 위한 listener
  //   setState(() {
  //
  //   }); // build 함수를 재실행하기 위해 설정
  // }
  //
  // @override
  // void dispose() { // controller에 등록된 listener 삭제
  //   tabController!.removeListener(tabListener);
  //   super.dispose();
  // }

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
      Container(
        child: Center(
          child: Text(
            "Tab 1",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      Container(
        child: Center(
          child: Text(
            "Tab 2",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
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
}