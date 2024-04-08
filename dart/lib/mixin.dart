import 'package:dart/person.dart';

mixin Meal on Person { // mixin으로 정의
  void breakfast() { // 해당 함수들은 이 mixin과 같이 person을 상속 받은 클래스에서 사용 가능
    print("지금부터 아침을 먹습니다.");
  }

  void lunch() {
    print("지금부터 점심을 먹습니다.");
  }

  void dinner() {
    print("지금부터 저녁을 먹습니다.");
  }
}