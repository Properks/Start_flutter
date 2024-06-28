import 'package:drift/drift.dart';
import 'package:scheduler/repository/schedule_repository.dart';
import 'package:scheduler/model/schedule_model.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class ScheduleProvider extends ChangeNotifier {
  final ScheduleRepository repository;

  DateTime selectedTime = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  Map<DateTime, List<ScheduleModel>> cache = {};

  ScheduleProvider({
    required this.repository,
  }) : super() {
    getSchedules(date: selectedTime);
  }

  void getSchedules({
    required DateTime date,
  }) async {
    final resp = await repository.getSchedules(date: date);
    cache.update(date, (value) => resp, ifAbsent: () => resp);// 존재하면 value를 resp로 없으면 resp 추가
    notifyListeners(); // 현재 listen하고 있는 위젯들을 다시 build
    // cache가 업데이트 될 때마다 업데이트하기 위해서
  }

  void createSchedule({
    required ScheduleModel model
}) async {
    final targetDate = model.date;
    // resp은 저장된 스케쥴의 Id

    final uuid = Uuid().v4();

    final cacheSchedule = model.copyWith(id: uuid);

    cache.update(targetDate, (value) => [ // targetDate에 해당하는 원래 일정 다 가져오기
      ...value, // 원래 일정 뒤에 추가
      cacheSchedule
      ]..sort(
        (a, b) => a.startTime.compareTo(b.startTime)
      ), ifAbsent: () => [cacheSchedule] // 해당 날짜의 일정이 없는 경우
    );

    notifyListeners(); // 캐시 반영

    try {
      final resp = await repository.createSchedule(model: model);

      cache.update(targetDate, (value) => value.map((e) => e.id == uuid ? e.copyWith(id: resp) : e).toList());
    } catch (e) {
      cache.update(targetDate, (value) => value.where((e) => e.id != uuid).toList());
    }

    notifyListeners(); // 캐시 반영
  }

  void deleteSchedule({
    required DateTime date,
    required String id
}) async {
    ScheduleModel? deletedSchedule = cache[date]!.firstWhere((element) => element.id == id);
    cache.update(date, (value) => value.where((element) => element.id != id).toList());

    try {
      await repository.deleteSchedule(id: id);
    } catch(e) {
      cache.update(date, (value) => [
        ...value,
        deletedSchedule,
      ]..sort((a, b) => a.startTime.compareTo(b.startTime))
      );
    }


    notifyListeners();
  }

  void changeSchedule({
    required DateTime date,
}) {
    selectedTime = date;
    notifyListeners();
  }
}