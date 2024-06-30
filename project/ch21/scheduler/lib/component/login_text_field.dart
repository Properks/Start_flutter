import 'package:calendar_scheduler/const/colors.dart';
import 'package:flutter/material.dart';

class LoginTextField extends StatelessWidget {

  final FormFieldSetter<String?> onSaved;
  final FormFieldValidator<String?> validator;
  final String? hintText;
  final bool  obscureText;


  const LoginTextField({
    required this.onSaved,
    required this.validator,
    this.hintText,
    this.obscureText = false,
    super.key,});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: onSaved,
      validator: validator,
      cursorColor: SECONDARY_COLOR,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        
        // 활성화된 경우
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: TEXT_FIELD_FILL_COLOR,
          ),
        ),
        
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: SECONDARY_COLOR,
          ),
        ),
        
        // 에러가 난 경우
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: ERROR_COLOR,
          ),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: ERROR_COLOR,
          ),
        ),
      ),
    );
  }
}
