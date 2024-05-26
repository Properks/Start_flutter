import 'package:flutter/material.dart';
import 'package:scheduler/component/main_calendar.dart';
import 'package:scheduler/component/schedule_bottom_sheet.dart';
import 'package:scheduler/component/schedule_card.dart';
import 'package:scheduler/component/today_banner.dart';
import 'package:scheduler/const/colors.dart';
import 'package:get_it/get_it.dart';
import 'package:scheduler/database/drift_database.dart';

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
            const SizedBox(height: 8,),
            StreamBuilder<List<Schedule>>(
              stream: GetIt.I<LocalDatabase>().watchSchedules(selectedDate),
              builder: (context, snapshot) {
                return TodayBanner(
                  selectedDate: selectedDate,
                  count: snapshot.data?.length ?? 0
                  // count: snapshot.hasData ? snapshot.data!.length : 0
                );
              },
            ),
            const SizedBox(height: 8,),
            Expanded(
              child: StreamBuilder<List<Schedule>>( // 데이터가 변경되면 새로 build
                stream: GetIt.I<LocalDatabase>().watchSchedules(selectedDate), // watchSchedule이 Stream을 반환
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Container();
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final schedule = snapshot.data![index];
                      return Dismissible(
                        key: ObjectKey(schedule.id), // 키 값을 schedule의 키로
                        direction: DismissDirection.startToEnd, // 왼쪽에서 오른쪽으로 밀기
                        onDismissed: (DismissDirection direction) {
                          GetIt.I<LocalDatabase>()
                              .removeSchedule(schedule.id);
                        },
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 8, left: 8, right: 8),
                          child: ScheduleCard(
                            startTime: schedule.startTime,
                            endTime: schedule.endTime,
                            content: schedule.content,
                          )
                        )
                      );
                    },
                  );
                },
              ),
            ),
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