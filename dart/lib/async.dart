import 'dart:async';

void main() async {
  // Future
  // await printFuture();

  // Async, await
  await printAsync();
  // await으로 해도 내부의 addTwoNumbersAwait(3, 3);는 비동기적으로 실행되기 때문에 밑의 함수를 실행한다.
  // *** 동기와 비동기는 병렬적으로 실행된다.


  // Stream
  await printStream();
}

Future<void> printFuture() async {
  print("Future");
  Future<String> name; // 미래에 String 값을 name 변수에 받는다.
  addTwoNumbers(1, 3);
}

Future<void> printAsync() async {
  print("\nAsync, await, 비동기 프로그래밍 특징 유지");
  addTwoNumbersAwait(1, 1);
  final result = await addTwoNumbersAwait(2, 2); // 이 함수가 끝날 때까지 기다리기
  print("addTwoNumbersAwait(2, 2): $result");
  // 비동기 프로그래밍 특징 유지

  addTwoNumbersAwait(3, 3);
}

Future<void> printStream() async {
  print("\nStream");
  final controller1 = StreamController();
  final stream1 = controller1.stream;

  final streamListener = stream1.listen((event) {
    print("stream.listen(): $event");
  });

  controller1.sink.add("sink");
  controller1.sink.add(1);
  controller1.sink.add(2.5);

  // 스트림 컨트롤러를 닫음으로써 스트림의 끝을 표시합니다.
  controller1.close();

  print("\nBroadcast Stream");
  final controller2 = StreamController();
  final stream2 = controller2.stream.asBroadcastStream();
  final streamListener1 = stream2.listen((event) {
    print("BroadcastStream.listen(): $event");
  });

  final streamListener2 = stream2.listen((event) {
    print("BroadcastStream.listen(): $event");
  });

  controller2.sink.add("Broadcast");
  controller2.sink.add(2);
  controller2.sink.add(3.3);

  controller2.close();

  // Stream 을 반환하는 함
  print("\nStream 반환");
  count().listen((event) {
    print("count().listen(): $event");
  });
}



/// 비동기 프로그래밍의 예제, 2번을 기다리지 않고 3번이 실행되어 1, 3, 2 순서로 실행된다.
void addTwoNumbers(int first, int second) {
  /// 1 번
  print("1: $first + $second 계산 시작");

  // 2 번, delayed 로 Duration 만큼 기다린 뒤에 함수를 실행한다.
  Future.delayed(Duration(seconds: 3), () {
    print("2: $first + $second = ${first + second}");
  });

  // 3 번
  print("3: $first + $second 계산 끝!");
}

/// 비동기 프로그래밍 예제, 2번에 await 을 선언해주어 2번을 기다리기에 1, 2, 3 순서로 실행된다.
Future<int> addTwoNumbersAwait(int first, int second) async {
  /// 1 번
  print("1: $first + $second 계산 시작");

  // 2 번, delayed 로 Duration 만큼 기다린 뒤에 함수를 실행한다.
  await Future.delayed(Duration(seconds: 3), () {
    print("2: $first + $second = ${first + second}");
  });

  // 3 번
  print("3: $first + $second 계산 끝!");

  return first + second;
}

Stream<String> count() async* {
  for(int i = 0; i < 5; i++) {
    yield "i = $i";
  }
}