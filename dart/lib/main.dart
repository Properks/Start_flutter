void main() {
  print("Variable");
  // var를 이용해서 변수를 선언하면 자료형 고정
  var number = 1;
  print(number);

  // dynamic을 이용하여 변수를 선언하면 바꿀 수 있음
  dynamic value = "name";
  print(value);

  value = 10;
  print(value);

  // const, final은 상수로 한 번 설정하면 변경할 수 없다
  // const는 실행 전에 값이 확정인 상태, final은 실행될 때 값이 확정인 상황 ex) final DateTime now = DateTime.now();
  const value1 = "name";
  final value2 = "name";
  // value1 = "name1"; error!
  // value2 = "name2"; error!

  //자료형
  String name = "name"; // 문자열
  int num = 1; // 정수
  double point = 2.5; // 실수
  bool isTrue = true; // Boolean

  // List
  print("\nList");
  List<String> strs = ['str1', 'str2'];
  strs.add("str3");
  print(strs);
  print(strs[0]);
  print(strs[1]);
  print("length of strs: ${strs.length}");


  // where(): 조건에 맞는 요소 찾기
  List<String> listWhere = strs.where((str) => str == "str1" || str == "str2").toList();
  print("where(): $listWhere");

  // map(): 조건 에 맞게 값을 변경
  List<String> listMap = strs.map((str) => "modified $str").toList();
  print("map(): $listMap");

  // reduce(): 배열의 값들을 쌓아서 하나로 만들기
  final listReduce = strs.reduce((value, element) => "$value, $element"); // 람다 함수
  strs.reduce((value, element) { // 익명 함수
    return "$value, $element";
  });
  print("reduce(): $listReduce");

  // fold(): reduce와 유사하지만 리스트 요소들의 타입이 달라도 된다'
  final listFold = strs.fold(0, (value, element) => value += element.length);
  print("fold(): $listFold");

  // Map
  print("\nMap");
  Map<int, String> map = {
    1111: "First",
    2222: "Second",
    3333: "Third"
  };
  print("map[1111]: ${map[1111]}");
  print("map: $map"); // map 출력
  print("map.keys ${map.keys}"); // map의 key들 출력
  print("map.values: ${map.values}"); // map의 value들 출력

  // Set
  print("\nSet");
  Set<String> set = {"A", "B", "C"};
  set.add("C"); // 이미 C가 있기 때문에 변경되지 않음
  print("set: $set");
  List<String> listToSet = ["A", "B", "B"];
  print(Set.from(listToSet)); // List를 Set으로 바꾸면서 중복된 "B"가 없어짐

  // null 관련 연산자
  print("\nNull 연산자");
  int? canNull = 1;
  print("int? canNull = 1;");
  print("canNull = 1 => $canNull");
  canNull ??= 4;
  print("canNull ??= 4 => $canNull"); // null이 아니기에 변경되지 않는다.
  canNull = null;
  print("canNull = null => $canNull");
  // int cantNull = null; // null을 가질 수 없다.

  // 타입 비교 연산자
  print("\n타입 비교 연산자");
  int typeComparison = 1;
  print("int typeComparison = 1;");
  print("typeComparison is int => ${typeComparison is int}");
  print("typeComparison is! int => ${typeComparison is! int}");
  print("typeComparison is String => ${typeComparison is String}");
  print("strs is List<String> => ${strs is List<String>}");
  print("map is Map => ${map is Map}");
  print("map is! Map => ${map is! Map}");

  // 함수
  print("\n함수");
  int addFunction = addTwoNumbers(123, 345);
  print("int addFunction = addTwosNumber(123, 345);");
  print("addFunction: $addFunction");
  print("addTwoNumbersRequired(first: 123, second: 124): ${addTwoNumbersRequired(first: 123, second: 124)}");
  print("addTwoNumbersBaseNumber(1) ${addTwoNumbersBaseNumber(1)}");
  print("addThreeNumbersMixed(12, second: 24) ${addThreeNumbersMixed(12, second: 24)}");


  // typedef
  print("\ntypedef");
  Operation operation = addTwoNumbers;
  print("Operation operation = addTwoNumbers;");
  print("operation(3, 2): ${operation(3, 2)}");
  operation = subtractTwoNumbers;
  print("operation = subtractTwoNumbers;");
  print("operation(3, 2): ${operation(3, 2)}");

  // try-catch
  print("\ntry-catch");
  try {
    throw FormatException("형식이 잘못되었습니다.");
  } catch(e) {
    print(e);
  }
}
int subtractTwoNumbers(int first, int second) {
  return first - second;
}

int addTwoNumbers(int first, int second) {
  return first + second;
}

int addTwoNumbersRequired({required int first, required int second}) {
  return first + second;
}

int addTwoNumbersBaseNumber(int first, [int second = 2]) {
  return first + second;
}

int addThreeNumbersMixed(int first, {required int second, int third = 3}) {
  return first + second + third;
}

typedef Operation = int Function(int a, int b); // 함수를 변경 가능