class Person {
  String? _name; // _를 변수명 앞에 붙이면 private 변수.
  int? age;

  // Constructor
  // Person(String name, int age) // 생성자는 :를 통하여 정의
  //     : this._name = name,
  //       this.age = age;


  Person(this._name, this.age); // this를 parameter로 받으면 바로 변수에 들어간다.

  // 네임드 생성자 named constructor 뒤의 fromMap은 프로그래머가 이름 짓기 나름
  Person.fromMap(Map<String, dynamic> parameter)
      : this._name = parameter["name"],
        this.age = parameter["age"];

  String? get name { // getter
    return this._name;
  }

  set name(String? name) { // setter
    this.name = name;
  }

  void introduce() {
    print("저는 ${this.age}살이고 이름은 ${this.name}입니다.");
  }

  void sayName() {
    print("저는 ${this.name}입니다.");
  }
}