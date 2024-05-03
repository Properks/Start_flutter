import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {

  final GestureTapCallback onPressed;
  final IconData icon;

  const CustomIconButton({
    required this.onPressed,
    required this.icon,
    super.key
  });



  @override
  Widget build(BuildContext context) {

    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon),
      iconSize: 30,
      color: Colors.white,
    );
  }
}