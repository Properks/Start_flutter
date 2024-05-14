import 'package:flutter/material.dart';
import 'package:scheduler/component/main_calendar.dart';

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
      body: SafeArea(
        child: Column(
          children: [
            MainCalendar(
              selectedDate: selectedDate,
              onDaySelected: onDaySelected,
            ),
          ],
        ),
      ),
    );
  }

  void onDaySelected(DateTime selectedDate, DateTime focusedDate) {
    setState(() {
      this.selectedDate = selectedDate;
      print("Selectd: " + selectedDate.toString() + ", Focus: " + focusedDate.toString());
      // 아직은 두개의 값이 같다.
    });
  }
}