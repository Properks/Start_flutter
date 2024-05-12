import 'package:cf_tube/component/custom_youtube_player.dart';
import 'package:cf_tube/repository/youtube_repository.dart';
import 'package:flutter/material.dart';

import '../model/video_model.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("유튜브 재생기"),
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder<List<VideoModel>>(
        future: YoutubeRepository.getVideos(),
        builder: (context, snapshot) {
          if (snapshot.hasError) { // 에러가 나면 처리
            return Center(
              child: Text(
                snapshot.error.toString()
              ),
            );
          }
          if (!snapshot.hasData) { // 데이터를 가져오는 중에 처리
            return const Center(
              child: CircularProgressIndicator()
            );
          }

          return RefreshIndicator( // 새로고침 기능이 있는 위젯
            // RefreshIndicator와 ListView를 같이 사용하여 스크롤을 내릴 때마다 새로고침하도록
            // onRefresh 에 setState를 넣어서 새로고침할 때마다 getVideo 실행
            onRefresh: () async {
              setState(() {});
            },
            child: ListView(
              physics: const BouncingScrollPhysics(), // 아래로 당겨서 스크롤할 때 튕기는 모션 추가
              children: snapshot.data!.map(
                (e) =>
                CustomYoutubePlayer(
                  videoModel: e,
                )
              ).toList()
            ),
          );
        },
      )
    );
  }
}