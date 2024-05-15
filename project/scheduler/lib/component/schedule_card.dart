import 'package:flutter/material.dart';
import 'package:scheduler/const/colors.dart';

class ScheduleCard extends StatelessWidget {
  final int startTime;
  final int endTime;
  final String content;

  const ScheduleCard({
    required this.startTime,
    required this.endTime,
    required this.content,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: PRIMARY_COLOR,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: IntrinsicHeight( // 높이를 내부 위젯들의 최대 높이로 설정
          // _Time은 Column 때문에 ScheduleCard의 최대 높이 만큼 차지
          // _Content는 최소만 차지
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _Time(startTime: startTime, endTime: endTime),
              const SizedBox(width: 16,),
              _Content(content: content),
              const SizedBox(width: 16,),
            ],
          ),
        ),
      ),
    );
  }
}

class _Time extends StatelessWidget {

  final int startTime;
  final int endTime;

  const _Time({
    required this.startTime,
    required this.endTime,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 16,
      color: PRIMARY_COLOR,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${startTime.toString().padLeft(2, '0')}:00",
          style: textStyle,
        ),
        Text(
          "${endTime.toString().padLeft(2, '0')}:00",
          style: textStyle.copyWith(
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}

class _Content extends StatelessWidget {

  final String content;

  const _Content({
    required this.content,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        content,
      ),
    );
  }
}