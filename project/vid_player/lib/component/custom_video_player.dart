import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vid_player/component/custom_icon_button.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';

class CustomVideoPlayer extends StatefulWidget {
  final XFile video;
  const CustomVideoPlayer({
    required this.video,
    super.key
  });

  @override
  State<StatefulWidget> createState() {
    return _CustomVideoPlayerState();
  }
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  VideoPlayerController? videoPlayerController;

  @override
  void initState() {
    super.initState();

    initializedController();
  }

  initializedController() async { // 파일 가져오기는 비동기적으로 실행
    final videoPlayerController = VideoPlayerController.file(
      File(widget.video.path) // 파일로 controller 생성
    );

    await videoPlayerController.initialize(); // 동영상을 재샐할 수 있는 상태로 만들기

    setState(() {
      this.videoPlayerController = videoPlayerController; // video controller 설정
    });
  }

  @override
  Widget build(BuildContext context) {
    if (videoPlayerController == null) { // video가 없을 때 로딩화면 구출
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return AspectRatio( // video의 비율에 맞게 설정
      aspectRatio: videoPlayerController!.value.aspectRatio,
      child: Stack(
        children: [
          VideoPlayer( // video player 설정
            videoPlayerController!,
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Slider(
              onChanged: (double val){
                videoPlayerController!.seekTo(
                  Duration(seconds: val.toInt())
                );
              },
              value: videoPlayerController!.value.position.inSeconds.toDouble(),
              min: 0,
              max: videoPlayerController!.value.duration.inSeconds.toDouble(),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: CustomIconButton(
              onPressed: () {},
              icon: Icons.photo_camera_back,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomIconButton(
                    onPressed: () {},
                    icon: Icons.rotate_left
                ),
                CustomIconButton(
                    onPressed: () {},
                    icon: Icons.play_arrow
                ),
                CustomIconButton(
                    onPressed: () {},
                    icon: Icons.rotate_right
                ),
              ],
            ),
          )
        ]
      ),
    );
  }
}