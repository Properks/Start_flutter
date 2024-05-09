import 'package:flutter/material.dart';

class EmoticonSticker extends StatefulWidget {
  final VoidCallback onTransform;
  final String imgPath;
  final bool isSelected;

  const EmoticonSticker({
    required this.onTransform,
    required this.imgPath,
    required this.isSelected,
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
    return Transform(
      transform: Matrix4.identity()
      ..translate(hTransform, vTransform)
      ..scale(scale, scale),
      child: Container(
        decoration: widget.isSelected ?
        BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(
            color: Colors.blue,
            width: 1.0,
          ),
        ):
            BoxDecoration(
              border: Border.all(
                color: Colors.transparent,
                width: 1.0
              )
            ),
        child: GestureDetector(
          onTap: () {
            widget.onTransform(); // ()를 붙여야 함수가 실행
          },
          onScaleUpdate: (ScaleUpdateDetails details) {
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
        ),
      ),
    );
  }
}