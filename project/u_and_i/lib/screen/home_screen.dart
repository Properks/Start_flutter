import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {

  DateTime firstDay = DateTime(2022, 12, 31);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      body: SafeArea(
        top:true,
        bottom: true,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _DDay(
                onHeartPressed: onHeartPressed,
                firstDay: firstDay,
              ),
              _CoupleImage(),
            ]
        ),
      ),
    );
  }

  void onHeartPressed(){
    setState(() {
      showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: Colors.white,
            height: 300,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (DateTime time) {
                setState(() {
                  firstDay = time;
                });
              }
            ),
          ),
        );
        },
        barrierDismissible: true,
      );
    });
  }
}



class _DDay extends StatelessWidget {
  _DDay({
    required this.onHeartPressed,
    required this.firstDay
  });
  final GestureTapCallback onHeartPressed;
  final DateTime firstDay;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final now = DateTime.now();
    return Column(
      children: [
        const SizedBox(height: 16),
        Text(
          "U & i",
          style: textTheme.headlineLarge,
        ),
        const SizedBox(height: 16),
        Text(
          "처음 만난 날",
          style: textTheme.bodyLarge,
        ),
        Text(
          "${firstDay.year}.${firstDay.month}.${firstDay.day}",
          style: textTheme.bodyMedium,
        ),
        const SizedBox(height: 16),
        IconButton(
          iconSize: 60,
          onPressed: onHeartPressed,
          icon: const Icon(
            Icons.favorite,
            color: Colors.red,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          "D+${now.difference(firstDay).inDays + 1}",
          style: textTheme.bodyMedium,
        ),
      ],
    );
  }
}

class _CoupleImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded( // height을 지정해줘서 overflow가 발생,
      // 이를 해결하기 위해 Expanded를 사용하여 남는 공간만 사용하도록 하기
      child: Center(
        child: Image.asset(
          "assets/img/middle_image.png",

          // 화면의 크기를 가지고 와서 높이에 2를 나눈 값
          // height: MediaQuery.of(context).size.height / 2,
        ),
      ),
    );
  }
}