import 'package:flutter/material.dart';
import 'package:scheduler/component/main_calendar.dart';
import 'package:scheduler/component/schedule_bottom_sheet.dart';
import 'package:scheduler/component/schedule_card.dart';
import 'package:scheduler/component/today_banner.dart';
import 'package:scheduler/const/colors.dart';

class HomeScreen extends StatefulWidget{

  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDate = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  @override
  Widget build(BuildContext context) {
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
              onDaySelected: onDaySelected,
            ),
            TodayBanner(selectedDate: selectedDate, count: 0),
            ScheduleCard(startTime: 13, endTime: 14, content: "공부")
          ],
        ),
      ),
    );
  }

  void onDaySelected(DateTime selectedDate, DateTime focusedDate) {
    if (this.selectedDate != selectedDate) { // 같은 날짜 선택 시 build함수를 재실행하지 않도록
      setState(() {
        this.selectedDate = selectedDate;
        print("Selectd: " + selectedDate.toString() + ", Focus: " + focusedDate.toString());
        // 아직은 두개의 값이 같다.
      });
    }
  }
}