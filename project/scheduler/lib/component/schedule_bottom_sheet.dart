import 'package:flutter/material.dart';
import 'package:scheduler/component/custom_text_field.dart';
import 'package:scheduler/const/colors.dart';

class ScheduleBottomSheet extends StatefulWidget {
  const ScheduleBottomSheet({
    super.key
  });

  @override
  State<StatefulWidget> createState() => _ScheduleBottomSheetState();
}

class _ScheduleBottomSheetState extends State<ScheduleBottomSheet> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height / 2,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
          child: Column(
            children: [
              const Row(
                children: [
                  Expanded(
                    child: CustomTextField(label: "시작 시간", isTime: true,)
                  ),
                  SizedBox(width: 16,),
                  Expanded(
                      child: CustomTextField(label: "종료 시간", isTime: true,)
                  ),
                ],
              ),
              const Expanded(
                child: CustomTextField(
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
    );
  }

  void onSavedPressed() {

  }

}