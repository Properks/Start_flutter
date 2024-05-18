import 'package:flutter/material.dart';
import 'package:scheduler/const/colors.dart';

class CustomTextField extends StatelessWidget {

  final String label;

  const CustomTextField({
    required this.label,
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
        TextFormField(),
      ],
    );
  }
}