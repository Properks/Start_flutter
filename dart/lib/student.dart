import 'package:dart/mixin.dart';
import 'package:dart/person.dart';

class Student extends Person with Meal{

  String major;

  // Man(String? name, int? age) : super(name, age);
  Student(super._name, super.age, this.major);

  @override
  void introduce() {
    print("저는 ${this.age}살 ${this.major} 전공인 학생, ${this.name}입니다.");
  }
}