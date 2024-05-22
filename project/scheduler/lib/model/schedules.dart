import 'package:drift/drift.dart';

class Schedules extends Table {
  IntColumn get id => integer().autoIncrement()(); // autoincrement 적용
  // 타입,       이름,    속성 설정
  TextColumn get content => text()();
  DateTimeColumn get date => dateTime()();
  IntColumn get startTime => integer()();
  IntColumn get endTime => integer()();
}