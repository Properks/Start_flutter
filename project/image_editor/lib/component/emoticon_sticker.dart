import 'package:flutter/material.dart';

class EmoticonSticker extends StatefulWidget {
  final VoidCallback onTransform;
  final String imgPath;

  const EmoticonSticker({
    required this.onTransform,
    required this.imgPath,
    super.key
  });

  @override
  State<StatefulWidget> createState() {
    return _EmoticonStickerState();
  }
}

class _EmoticonStickerState extends State<EmoticonSticker> {

  double scale = 1; // 위젯의 변경된 배율
  double hTransform = 0;
  double vTransform = 0;
  double actualScale = 1; // 위젯의 현재 배율

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTransform;
      },
      onScaleUpdate: (ScaleUpdateDetails details) {
        widget.onTransform;
        setState(() {
          scale = details.scale * actualScale; // 변경된 배율 설정
          hTransform += details.focalPointDelta.dx; // x 값 위치 변경
          vTransform += details.focalPointDelta.dy; // y 값 위치 변경
        });
      },
      onScaleEnd: (ScaleEndDetails details) {
        actualScale = scale; // 현재 배율 변경
      },
      child: Image.asset(
        widget.imgPath,
      ),
    );
  }
}