import 'package:drift/drift.dart';
import 'package:scheduler/repository/schedule_repository.dart';
import 'package:scheduler/model/schedule_model.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  }

  void createSchedule({
    required ScheduleModel model
}) async {
    final targetDate = model.date;
    final resp = await repository.createSchedule(model: model);
    // resp은 저장된 스케쥴의 Id

    cache.update(targetDate, (value) => [ // targetDate에 해당하는 원래 일정 다 가져오기
      ...value, // 원래 일정 뒤에 추가
      model.copyWith(id: resp), // 스케쥴 내용에 id만 추가해서 삽입
      ]..sort(
        (a, b) => a.startTime.compareTo(b.startTime)
      ), ifAbsent: () => [model.copyWith(id: resp)] // 해당 날짜의 일정이 없는 경우
    );

    notifyListeners();
  }

  void deleteSchedule({
    required DateTime date,
    required String id
}) async {
    final resp = repository.deleteSchedule(id: id);

    cache.update(date, (value) =>
      value.where((e) => e.id != id).toList(),
      ifAbsent: () => []
    );

    notifyListeners();
  }

  void changeSchedule({
    required DateTime date,
}) {
    selectedTime = date;
    notifyListeners();
  }
}