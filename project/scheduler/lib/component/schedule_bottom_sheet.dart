import 'package:flutter/material.dart';
import 'package:scheduler/component/custom_text_field.dart';
import 'package:scheduler/const/colors.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:get_it/get_it.dart';
import 'package:scheduler/database/drift_database.dart';

class ScheduleBottomSheet extends StatefulWidget {
  final DateTime selectedDate;
  const ScheduleBottomSheet({
    required this.selectedDate,
    super.key
  });

  @override
  State<StatefulWidget> createState() => _ScheduleBottomSheetState();
}

class _ScheduleBottomSheetState extends State<ScheduleBottomSheet> {

  final GlobalKey<FormState> key = GlobalKey(); // Form 형태의 키 생성

  int? startTime;
  int? endTime;
  String? content;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom; // 가상 키보드의 높이 가져오기
    return Form( // Form으로 TextFormField에 있는 값 쉽게 가져오기
      key: key,
      child: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height / 2 + bottomInset,
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.only(left: 8, right: 8, top: 8, bottom: bottomInset),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        onSaved: (startTime) {
                          this.startTime = int.parse(startTime!);
                        },
                        validator: timeValidator,
                        label: "시작 시간",
                        isTime: true,
                      ),
                    ),
                    const SizedBox(width: 16,),
                    Expanded(
                      child: CustomTextField(
                        onSaved: (endTime) {
                          this.endTime = int.parse(endTime!);
                        },
                        validator: timeValidator,
                        label: "종료 시간",
                        isTime: true,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: CustomTextField(
                    onSaved: (content) {
                      this.content = content!;
                    },
                    validator: contentValidator,
                    label: "내용",
                    isTime: false,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onSavedPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PRIMARY_COLOR,
                    ),
                    child: const Text(
                      "저장",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ),
    );
  }

  void onSavedPressed() async {
    if (key.currentState!.validate()) {
      key.currentState!.save();

      await GetIt.I<LocalDatabase>().createSchedule(
        SchedulesCompanion(
          startTime: Value(startTime!),
          endTime: Value(endTime!),
          content: Value(content!),
          date: Value(widget.selectedDate)
        )
      );

      Navigator.of(context).pop();
    }
  }

  String? timeValidator(String? time) {
    if (time == null) {
      return "값을 입력해주세요";
    }

    int? number;

    try {
      number = int.parse(time);
    } catch (e) {
      return "숫자를 입력해주세요";
    }

    if (number < 0 || number > 24) {
      return "0부터 24 사이의 값을 입력해주세요";
    }

    return null;
  }

  String? contentValidator(String? content) {
    if (content == null || content.isEmpty) {
      return "값을 입력해주세요";
    }
    return null;
  }

}