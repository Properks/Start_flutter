import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Scaffold(
      body: PageView(
        children: [1, 2, 3, 4, 5]
        .map((number) =>
            Image.asset(
              "assets/img/image_$number.jpeg",
              fit: BoxFit.fill,
            ),
        ).toList(),
      ),
    );
  }
}