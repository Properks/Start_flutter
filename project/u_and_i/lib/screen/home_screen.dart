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
    return Column(
      children: [
        const SizedBox(height: 16),
        const Text("U & i"),
        const SizedBox(height: 16),
        const Text("처음 만난 날"),
        const Text("2022.12.31"),
        const SizedBox(height: 16),
        IconButton(
          iconSize: 60,
          onPressed: () {},
          icon: const Icon(
              Icons.favorite
          ),
        ),
        const SizedBox(height: 16),
        const Text("D + 365"),
      ],
    );
  }
}

class _CoupleImage extends StatelessWidget {
  _CoupleImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        "assets/img/middle_image.png",

        // 화면의 크기를 가지고 와서 높이에 2를 나눈 값
        height: MediaQuery.of(context).size.height / 2,
      ),
    );
  }
}