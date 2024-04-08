import 'package:dart/person.dart';

class Employee implements Person {
  final String name;
  final int age;
  final String department;

  Employee(this.name, this.age, this.department);

  @override
  void introduce() { // 함수 구현
    print("저는 ${department} 부서에서 일하고 있는 ${this.name}입니다.");
  }

  @override
  void sayName() {
    print("저의 이름은 ${this.name}입니다.");
    // super.sayName() 불가능, 구현해야함
  }

  @override
  set name(String? name) {
    this.name = name;
  }

  @override
  set age(int? _age) {
    this.age = _age;
  }

}