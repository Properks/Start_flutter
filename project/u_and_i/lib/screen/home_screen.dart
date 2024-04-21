import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {

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
              _DDay(),
              _CoupleImage(),
            ]
          ),
      ),
    );
  }
}

class _DDay extends StatelessWidget {
  _DDay({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
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
          "2022.12.31",
          style: textTheme.bodyMedium,
        ),
        const SizedBox(height: 16),
        IconButton(
          iconSize: 60,
          onPressed: () {},
          icon: const Icon(
            Icons.favorite,
            color: Colors.red,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          "D + 365",
          style: textTheme.bodyMedium,
        ),
      ],
    );
  }
}

class _CoupleImage extends StatelessWidget {
  _CoupleImage({super.key});

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