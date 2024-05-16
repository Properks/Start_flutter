import 'package:flutter/material.dart';
import 'package:scheduler/const/colors.dart';

class TodayBanner extends StatelessWidget {
  final DateTime selectedDate;
  final int count; // 일정 개수

  const TodayBanner({
    required this.selectedDate,
    required this.count,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      fontWeight: FontWeight.w600,
      color: Colors.white,
    );

    return Container(
      color: PRIMARY_COLOR,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${selectedDate.year.toString()}.${selectedDate.month.toString().padLeft(2, '0')}.${selectedDate.day.toString().padLeft(2, '0')}",
              style: textStyle,
            ),
            Text(
              "${count.toString()}개",
              style: textStyle,
            ),
          ],
        ),
      ),
    );
  }
}