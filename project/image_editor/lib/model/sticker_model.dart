import 'package:flutter/material.dart';

class StickerModel {
  final String id;
  final String imgPath;

  const StickerModel({
    required this.id,
    required this.imgPath
  });

  @override
  bool operator ==(Object other) {
    return (other as StickerModel).id == id;
  }

  int get hashcode => id.hashCode;


}