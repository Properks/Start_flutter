import 'package:flutter/material.dart';

typedef OnEmotionTap = void Function(int id);
class Footer extends StatelessWidget {

  final OnEmotionTap onEmotionTap;
  final int emoticonNumber = 7;

  const Footer({
    required this.onEmotionTap,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(0.9),
      height: 150,
      child: SingleChildScrollView( // scroll 생성
        scrollDirection: Axis.horizontal, // 가로로 scroll 생성
        child: Row(
          children: List.generate(emoticonNumber, (index) =>  // 개수만큼 list로 생성해서 children에 삽입
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 8.0),
            child: GestureDetector(
              onTap: () {
                onEmotionTap(index + 1);
              },
              child: Image.asset(
                "assets/img/emoticon_${index + 1}.png",
                height: 100,
              ),
            )
          )),
        ),
      ),
    );
  }
}