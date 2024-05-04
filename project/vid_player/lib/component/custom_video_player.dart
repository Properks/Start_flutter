import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vid_player/component/custom_icon_button.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';

class CustomVideoPlayer extends StatefulWidget {
  final XFile video;
  final GestureTapCallback onNewVideoPressed;
  const CustomVideoPlayer({
    required this.video,
    required this.onNewVideoPressed,
    super.key
  });

  @override
  State<StatefulWidget> createState() {
    return _CustomVideoPlayerState();
  }
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  VideoPlayerController? videoPlayerController;
  bool showControl = false;

  @override
  void didUpdateWidget(covariant CustomVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.video.path != widget.video.path) {
      initializedController();
    }
  }

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

    videoPlayerController.addListener(videoPlayerControllerListener);

    setState(() {
      this.videoPlayerController = videoPlayerController; // video controller 설정
      this.videoPlayerController!.play(); // videoPlayerController가 설정되자마자 바로 동영상 실행
    });
  }

  void videoPlayerControllerListener() {
    setState(() { // build를 다시 실행하며 value: videoPlayerController!.value.position.inSeconds.toDouble(),가 재실행되도록

    });
  }

  @override
  void dispose() {
    videoPlayerController?.removeListener(videoPlayerControllerListener);
    super.dispose();
  }
  // ?. vs !. -> !.: null이라고 생각하고 접근, 만약 null이면 NullPointerException 발생, ?.: null인지 check하고 null이면 접근하지 않고 null을 반환

  @override
  Widget build(BuildContext context) {
    if (videoPlayerController == null) { // video가 없을 때 로딩화면 구출
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          showControl = !showControl;
        });
      },
      child: AspectRatio( // video의 비율에 맞게 설정
      aspectRatio: videoPlayerController!.value.aspectRatio,
      child: Stack(
        children: [
          VideoPlayer( // video player 설정
            videoPlayerController!,
          ),
          if (showControl)
            Container(
              color: Colors.black.withOpacity(0.5),
            ),
          // if (showControl)
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    Expanded(
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
                    showRenderTime(videoPlayerController!.value.position, videoPlayerController!.value.duration),
                  ]
                ),
              )
            ),
          if (showControl)
            Align(
              alignment: Alignment.topRight,
              child: CustomIconButton(
                onPressed: widget.onNewVideoPressed,
                icon: Icons.photo_camera_back,
              ),
            ),
          if (showControl)
            Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomIconButton(
                      onPressed: onReservedPressed,
                      icon: Icons.rotate_left
                  ),
                  CustomIconButton(
                      onPressed: onPlayPressed,
                      icon: videoPlayerController!.value.isPlaying ? Icons.pause : Icons.play_arrow
                  ),
                  CustomIconButton(
                      onPressed: onForwardPressed,
                      icon: Icons.rotate_right
                  ),
                ],
              ),
            ),
        ]
      ),
    )
    );
  }

  void onReservedPressed() {
    final currentPosition = videoPlayerController!.value.position;

    Duration position = const Duration();

    if (currentPosition.inSeconds > 3) {
      position = currentPosition - const Duration(seconds: 3);
    }

    videoPlayerController!.seekTo(position);
  }

  void onForwardPressed() {
    final currentPosition = videoPlayerController!.value.position;
    final maxPosition = videoPlayerController!.value.duration;

    Duration position = maxPosition;

    if (maxPosition.inSeconds - position.inSeconds > 3) {
      position = currentPosition + const Duration(seconds: 3);
    }

    videoPlayerController!.seekTo(position);
  }

  void onPlayPressed() {
    bool isPlaying = videoPlayerController!.value.isPlaying;

    if (isPlaying) {
      videoPlayerController!.pause();
    }
    else {
      videoPlayerController!.play();
    }
    setState(() {}); // build 재실행으로 pause, play button 변경
  }

  Widget showRenderTime(Duration position, Duration duration) {
    return Text(
      "${position.inMinutes.toString().padLeft(2, '0')}:${(position.inSeconds % 60).toString().padLeft(2, '0')}/${duration.inMinutes.toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}",
      style: const TextStyle(
        color: Colors.white,
      ),
    );
  }
}