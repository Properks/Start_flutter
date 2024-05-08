import 'package:flutter/material.dart';
import 'package:image_editor/component/main_app_bar.dart';
import 'package:image_editor/component/footer.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key});
  
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen>{

  XFile? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          renderBody(),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: MainAppBar(
              onPickImage: onPickImage,
              onSaveImage: onSaveImage,
              onDeleteItem: onDeleteImage,
            ),
          ),
          if (image != null)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Footer(
                onEmotionTap: onEmotionTap,
              ),
            ),
        ],
      ),
    );
  }

  Widget renderBody() {
    if (image == null) {
      return Center(
        child: TextButton(
          style: TextButton.styleFrom(
             foregroundColor: Colors.grey,
          ),
          onPressed: onPickImage,
          child: Text(
            "사진을 선택해주세요"
          ),
        ),
      );
    }
    return Positioned.fill(
      child: InteractiveViewer(
        child: Image.file(
          File(image!.path),
        ),
      ),
    );
  }

  void onPickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      this.image = image;
    });
  }

  void onSaveImage() {}

  void onDeleteImage() {}

  void onEmotionTap(int index) {}
}