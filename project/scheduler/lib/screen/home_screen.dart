import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scheduler/component/main_calendar.dart';
import 'package:scheduler/component/schedule_bottom_sheet.dart';
import 'package:scheduler/component/schedule_card.dart';
import 'package:scheduler/component/today_banner.dart';
import 'package:scheduler/const/colors.dart';
import 'package:get_it/get_it.dart';
import 'package:scheduler/database/drift_database.dart';
import 'package:scheduler/model/schedule_model.dart';
import 'package:scheduler/provider/schedule_provider.dart';

class HomeScreen extends StatefulWidget{


  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  DateTime selectedDate = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );


  @override
  Widget build(BuildContext context) {
    // final provider = context.watch<ScheduleProvider>();
    // final selectedDate = provider.selectedTime;
    // final schedules = provider.cache[selectedDate] ?? [];
    final schedules = FirebaseFirestore.instance.collection('schedule').get();

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
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection('schedule').where(
                'date',
                isEqualTo: '${selectedDate.year}${selectedDate.month}${selectedDate.day}'
              ).snapshots(),
              builder: (context, snapshot) {
                return TodayBanner(
                  selectedDate: selectedDate,
                  count: snapshot.data?.docs.length ?? 0,
                );
              },
            ),
            // TodayBanner(
            //   selectedDate: selectedDate,
            //   count: 0,
            // ),
            const SizedBox(height: 8,),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('schedule').where(
                    'date',
                    isEqualTo: '${selectedDate.year}${selectedDate.month.toString().padLeft(2, '0')}${selectedDate.day.toString().padLeft(2, '0')}',
                  // padLeft를 추가하지 않으면 2024629로 나가고 데이터베이스에는 20240629로 저장되어서 못찾는다.
                ).snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: Text("일정을 가져오지 못했습니다."),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container();
                  }
                  final schedules = snapshot.data!.docs.map((QueryDocumentSnapshot e) => ScheduleModel.fromJson(
                    json: (e.data() as Map<String, dynamic>),
                  )).toList();

                  return ListView.builder(
                    itemCount: schedules.length,
                    itemBuilder: (context, index) {
                      final schedule = schedules[index];
                      return Dismissible(
                        key: ObjectKey(schedule.id), // 키 값을 schedule의 키로
                        direction: DismissDirection.startToEnd, // 왼쪽에서 오른쪽으로 밀기
                        onDismissed: (DismissDirection direction) {
                          // provider.deleteSchedule(date: selectedDate, id: schedule.id);
                          FirebaseFirestore.instance.collection('schedule').doc(schedule.id).delete();
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
    // final provider = context.read<ScheduleProvider>();
    // provider.changeSchedule(date: selectedDate);
    // provider.getSchedules(date: selectedDate);
    setState(() {
      this.selectedDate = selectedDate;
    });
  }
}