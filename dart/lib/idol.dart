abstract class Idol {
  final String name;
  int memberCount;

  Idol(this.name, this.memberCount);

  void introduceGroup(); // 선언만 하고 상속된 클래스에서 구현

  void sing();
}