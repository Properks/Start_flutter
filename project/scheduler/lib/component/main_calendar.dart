import 'package:flutter/material.dart';
import 'package:scheduler/const/colors.dart';
import 'package:table_calendar/table_calendar.dart';

class MainCalendar extends StatelessWidget {
  final OnDaySelected onDaySelected;
  final DateTime selectedDate;

  const MainCalendar({
    required this.onDaySelected,
    required this.selectedDate,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      onDaySelected: onDaySelected, // 날짜가 선택되었을 때 실행할 함수
      selectedDayPredicate: (date) => // boolean으로 반환해 true면 선택된 날짜, false면 선택되지 않은 날짜로 선정
        date.year == selectedDate.year &&
        date.month == selectedDate.month &&
        date.day == selectedDate.day,
      focusedDay: DateTime.now(),
      firstDay: DateTime(1000, 1, 1),
      lastDay: DateTime(3000, 1, 1),
      headerStyle: const HeaderStyle(
        titleCentered: true, // 제목 중간
        formatButtonVisible: false, // 달력 크기 옵션 삭제
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 16
        ),
      ),
      calendarStyle: CalendarStyle(
        isTodayHighlighted: false,
        defaultDecoration: BoxDecoration(
          color: LIGHT_GREY_COLOR,
          borderRadius: BorderRadius.circular(6),
        ),
        weekendDecoration: BoxDecoration(
            color: LIGHT_GREY_COLOR,
            borderRadius: BorderRadius.circular(6),
        ),
        selectedDecoration: BoxDecoration(
          color: LIGHT_GREY_COLOR,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: PRIMARY_COLOR,
          ),
        ),
        defaultTextStyle: TextStyle(
          fontWeight: FontWeight.w600,
          color: DARK_GREY_COLOR,
        ),
        weekendTextStyle: TextStyle(
          fontWeight: FontWeight.w600,
          color: DARK_GREY_COLOR,
        ),
        selectedTextStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          color: PRIMARY_COLOR,
        ),
      ),
    );
  }
}