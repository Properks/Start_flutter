import 'package:flutter/material.dart';
import 'package:random_dice/const/colors.dart';

class HomeScreen extends StatelessWidget {
  final int number;

  const HomeScreen({
    required this.number,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
                "assets/img/$number.png"
            ),
          ),
          const SizedBox(height: 32.0,),
          Text(
            "행운의 숫자",
            style: TextStyle(
              color: secondaryColor,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 32.0,),
          Text(
            number.toString(),
            style: TextStyle(
              color: primaryColor,
              fontSize: 60,
              fontWeight: FontWeight.w200,
            ),
          )
        ],
      ),
    );
  }

}