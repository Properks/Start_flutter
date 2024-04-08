// 다트 3.0에 관한 신규 문법
void main() {
  // Record
  print("Record");
  (String, int, bool) gradeMath = ("John", 85, true);
  print("gradeMath: $gradeMath");
  print(gradeMath.$1);

  (String name, int grade, bool isPass) gradeEn = ("Tom", 55, false);
  print("gradeEn: $gradeEn");
  print("gradeEn isPass: ${gradeEn.$3}");

  // Destructuring 구조 분해
  print("\nDestructuring");
  final teddy = ["teddy", 17];
  final [name, age] = teddy;
  print("final [name, age] = teddy;");
  print("name: $name");
  print("age: $age");

  Map<String, dynamic> map = {
    "subject": "subject",
    "grade": 93
  };
  final {"subject": subject, "grade": score} = map; // {(map에서의 변수명): (사용할 변수명)}

  print("subject: $subject");
  print("score: $score");

  // Switch
  print("\nSwitch");
  String monday = "월요일";
  String wednesday = "수요일";

  String mondayEnglish = switchEnglish(monday);
  String wednesdayEnglish = switchEnglish(wednesday);

  print("mondayEnglish: $mondayEnglish");
  print("wednesdayEnglish: $wednesdayEnglish");
}

String switchEnglish(String day) {
  return switch (day) {
    "월요일" => "Monday",
    "화요일" => "Tuesday",
    _ => "Not found"
  };
}

// 인스턴스화 가능, 자식은 base, final sealed 제한자가 있어야 extends 가능. implement 불가능
base class Base {}

// 인스턴스화 가능, 외부 파일에서 extends, implement 불가능
final class Final {}

// 인스턴스화 가능, implement 만 할 수 있게 제한
interface class Interface {}

// 외부 파일에서 인스턴스화, extends, implements 불가능
sealed class Sealed {}

// mixin 처럼 사용 가, 상속도 가능
mixin class Mixin {}