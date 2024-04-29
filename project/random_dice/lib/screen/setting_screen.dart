import 'package:flutter/material.dart';
import 'package:random_dice/const/colors.dart';

class SettingScreen extends StatelessWidget {
  final double threshold;
  final ValueChanged<double> onThresholdChanged;

  const SettingScreen({
    required this.threshold,
    required this.onThresholdChanged,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Row(
            children: [
              Text(
                "민감도",
                style: TextStyle(
                  color: secondaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        Slider(
          min: 0.1,
          max: 10,
          value: threshold,
          onChanged: onThresholdChanged,
          label: threshold.toStringAsFixed(1),
        ),
      ],
    );
  }
}