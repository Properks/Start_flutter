import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scheduler/const/colors.dart';

class CustomTextField extends StatelessWidget {

  final String label;
  final bool isTime;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator; // valid한지 확인

  const CustomTextField({
    required this.label,
    required this.isTime,
    required this.onSaved,
    required this.validator,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: PRIMARY_COLOR,
            fontWeight: FontWeight.w600,
          ),
        ),
        Expanded(
          flex: isTime ? 0 : 1,
          child: TextFormField(
            onSaved: onSaved,
            validator: validator,
            cursorColor: Colors.grey,
            maxLines: isTime ? 1 : null, // null이면 제한 없음
            expands: !isTime, // 시간이면 부모 공간 만큼 차지, 아니면 최소 공간
            keyboardType: isTime ? TextInputType.number : TextInputType.multiline, // 시간이면 숫자 아니면 키보드
            inputFormatters: isTime ? [ // 시간인 경우 숫자로 제한
              FilteringTextInputFormatter.digitsOnly
            ] : [],
            decoration: InputDecoration(
              border: InputBorder.none, // 테두리 없음
              filled: true, // 배경색 on
              fillColor: Colors.grey[300], // 배경색
              suffixText: isTime ? "시" : null, // 시간이면 뒤에 시를 붙이기
            ),
          ),
        ),
      ],
    );
  }
}