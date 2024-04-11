import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Text(
              "클릭"
          ),
        ),
        body: Center(
          // SafeArea 노치 디자인등이 위젯을 가리는 것을 방지, true 면 가리지 않도록 safearea에 적용
          child: SafeArea(
            top: true,
            bottom: true,
            right: true,
            left: true,
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "버튼 연습", // 작성하고 싶은 글
                      style: TextStyle(
                        fontSize: 16, // 글자 크기
                        fontWeight: FontWeight.w700, // 글자 굵기
                        color: Colors.cyanAccent, // 글자 색
                      ),
                    ),
                    TextButton(
                      // 클릭시 실행할 함수
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.red,
                      ),
                      child: const Text("텍스트 버튼"),
                    ),
                    OutlinedButton(
                      // 클릭시 실행할 함수
                      onPressed: (){},
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.green,
                      ),
                      child: const Text("Outlined button"),
                    ),
                    ElevatedButton(
                      // 클릭시 실행할 함수
                      onPressed: (){},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                      ),
                      child: const Text(
                        "Elevated button",
                        style: TextStyle(
                            color: Colors.white
                        ),),
                    ),
                    IconButton(
                      // 클릭시 실행할 함수
                      onPressed: (){},
                      icon: const Icon(Icons.home),
                    ),
                    GestureDetector(
                      onTap: () {
                        print("on tap");
                      },
                      onDoubleTap: () {
                        print("on double tap");
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.amber
                        ),
                        width: 100,
                        height: 100,
                      ),
                    ),
                  ],
                ),

                //container
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        // padding container와 위젯 사이의 공백을 두고 싶을 때
                        padding: const EdgeInsets.all(
                            10.0
                        ),

                        // margin 바깥 여백 설정
                        margin: const EdgeInsets.all(
                            5.0
                        ),

                        decoration: BoxDecoration(
                          // 배경색
                          color: Colors.blue,

                          // 테두리
                          border: Border.all(
                            // 테두리 굵기
                            width: 10,
                            // 테두리 색
                            color: Colors.amber,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        // 넓이
                        width: 100,
                        //높이
                        height: 200,

                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                color: Colors.red,
                                width: double.maxFinite,
                                height: 75,
                              ),

                              // SizedBox 일정 크기의 공백을 두고 싶을 때
                              const SizedBox(
                                height: 10,
                                width: 200,
                              ),
                              Container(
                                color: Colors.red,
                                width: double.maxFinite,
                                height: 75,
                              ),
                            ]
                        ),
                      ),
                    ]
                ),
              ],
            ),
          )
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
