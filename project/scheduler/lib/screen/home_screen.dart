import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scheduler/component/main_calendar.dart';
import 'package:scheduler/component/schedule_bottom_sheet.dart';
import 'package:scheduler/component/schedule_card.dart';
import 'package:scheduler/component/today_banner.dart';
import 'package:scheduler/const/colors.dart';
import 'package:get_it/get_it.dart';
import 'package:scheduler/database/drift_database.dart';
import 'package:scheduler/provider/schedule_provider.dart';

class HomeScreen extends StatelessWidget {
  DateTime selectedDate = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ScheduleProvider>();
    final selectedDate = provider.selectedTime;
    final schedules = provider.cache[selectedDate] ?? [];

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: PRIMARY_COLOR,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isDismissible: true, // 배경 탭하면 창 닫기
            builder: (_)  => ScheduleBottomSheet(
              selectedDate: selectedDate,
            ),
            isScrollControlled: true, // 스크롤이 가능하도록
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            MainCalendar(
              selectedDate: selectedDate,
              onDaySelected: (selectedDate, focusedDate) => onDaySelected(selectedDate, focusedDate, context),
            ),
            const SizedBox(height: 8,),
            TodayBanner(
              selectedDate: selectedDate,
              count: schedules.length,
            ),
            const SizedBox(height: 8,),
            Expanded(
              child: ListView.builder(
                itemCount: schedules.length,
                itemBuilder: (context, index) {
                  final schedule = schedules[index];
                  return Dismissible(
                    key: ObjectKey(schedule.id), // 키 값을 schedule의 키로
                    direction: DismissDirection.startToEnd, // 왼쪽에서 오른쪽으로 밀기
                    onDismissed: (DismissDirection direction) {
                      provider.deleteSchedule(date: selectedDate, id: schedule.id);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 8, left: 8, right: 8),
                      child: ScheduleCard(
                        startTime: schedule.startTime,
                        endTime: schedule.endTime,
                        content: schedule.content,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onDaySelected(DateTime selectedDate, DateTime focusedDate, BuildContext context) {
    final provider = context.read<ScheduleProvider>();
    provider.changeSchedule(date: selectedDate);
    provider.getSchedules(date: selectedDate);
  }
}