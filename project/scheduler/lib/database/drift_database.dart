import 'package:scheduler/model/schedules.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

part 'drift_database.g.dart';

@DriftDatabase(
  tables: [
    Schedules,
  ]
)

class LocalDatabase extends _$LocalDatabase {
  LocalDatabase() : super(_openConnection());

  // Schedules를 찾는 쿼리
  Stream<List<Schedule>> watchSchedules(DateTime date) =>
      (select(schedules)..where((tbl) => tbl.date.equals(date))).watch();

  // Schedule을 생성하는 쿼리
  Future<int> createSchedule(SchedulesCompanion data) =>
      into(schedules).insert(data);

  // Schedule을 삭제하는 쿼리
  Future<int> removeSchedule(int id) =>
      (delete(schedules)..where((tbl) => tbl.id.equals(id))).go();

  // database가 변한다는 것을 인식하는 변수 1씩 올려 사용
  int get schemaVersion => 1;
}

/// 파일 내의 경로에 데이터를 저장하기 위해 연결하는 함수
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory(); // ➊ 데이터베이스 파일 저장할 폴더
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}