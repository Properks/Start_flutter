import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image_editor/component/emoticon_sticker.dart';
import 'package:image_editor/component/main_app_bar.dart';
import 'package:image_editor/component/footer.dart';
import 'package:image_editor/model/sticker_model.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;


class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key});
  
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen>{

  XFile? image;
  Set<StickerModel> stickers = {}; // 생성된 이모티콘 관리
  String? selectedId;
  GlobalKey imgKey = GlobalKey();

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
    return RepaintBoundary( // 사진 저장을 위해 설정
      key: imgKey,
      child: Stack(
        children: [
          Positioned.fill(
            child: InteractiveViewer( // 위젯 확대 이동 가능하도록 하는 뷰
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.file(
                        File(image!.path),
                      ),
                    ],
                  ),
                  ...stickers.map((e) => Center( // ...stickers => stickers의 값들을 가져오기
                    child: EmoticonSticker( // 생성된 이모티콘을 화면에 표시
                      key: ObjectKey(e.id),
                      imgPath: e.imgPath,
                      isSelected: selectedId == e.id,
                      onTransform: () {
                        onTransform(e.id);
                      },
                    ),
                  )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onPickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      this.image = image;
    });
  }

  void onSaveImage() async { // 이미지 저장
    RenderRepaintBoundary boundary = imgKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image img = await boundary.toImage(); // boundary를 이미지로 변경
    ByteData? data = await img.toByteData(format: ui.ImageByteFormat.png); // 이미지를 바이트로 변경
    Uint8List png = data!.buffer.asUint8List(); // Unit8List로 변경
    
    await ImageGallerySaver.saveImage(png, quality: 100);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "저장되었습니다."
        ),
      ),
    );
  }

  void onDeleteImage() async {
    setState(() {
      stickers = stickers.where((element) => element.id != selectedId).toSet();
      // 선택된 것 제외하고 Set으로 생성
    });
  }

  void onEmotionTap(int index) async{
    final Set<StickerModel> stickers = Set.from(this.stickers);
    stickers.add(StickerModel(
        id: Uuid().v4(),
        imgPath: "assets/img/emoticon_$index.png"
    ));
    setState(() {
      this.stickers = stickers;
    });
  }

  void onTransform(String id) {
    setState(() {
      selectedId = id;
    });
  }
}