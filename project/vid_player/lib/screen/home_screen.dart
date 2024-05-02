import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vid_player/component/custom_video_player.dart';

class HomeScreen extends StatefulWidget{

  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }

}

class _HomeScreenState extends State<HomeScreen> {
  XFile? video;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: video != null ? renderVideo() : renderEmpty(),
    );
  }

  Widget renderEmpty() { // video가 없을 때의 함수
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: getBoxDecoration(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _Logo(
            onTap: onNewVideoPressed,
          ),
          const SizedBox(height: 30),
          _AppName()
        ],
      ),
    );
  }

  BoxDecoration getBoxDecoration() {
    return const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF2A3A7C),
          Color(0xFF000118),
        ],
      ),
    );
  }

  void onNewVideoPressed() async {
    final video = await ImagePicker().pickVideo( // ImagePicker를 사용하여 비디오 선택
        source: ImageSource.gallery // 갤러리에서 선택
    );

    if (video != null) {
      setState(() {
        this.video = video;
      });
    }
  }

  Widget renderVideo() { // video가 있을 때 함수
    return Center(
      child: CustomVideoPlayer(
        video: video!,
      ),
    );
  }
}

class _Logo extends StatelessWidget{
  final GestureTapCallback onTap;

  const _Logo({
    required this.onTap,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(
        "asset/img/logo.png",
      ),
    );

  }
}

class _AppName extends StatelessWidget {
  const _AppName({super.key});

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      color: Colors.white,
      fontSize: 30,
      fontWeight: FontWeight.w300,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "VIDEO",
          style: textStyle,
        ),
        Text(
          "PLAYER",
          style: textStyle.copyWith(fontWeight: FontWeight.w700),
        )
      ],
    );
  }
}