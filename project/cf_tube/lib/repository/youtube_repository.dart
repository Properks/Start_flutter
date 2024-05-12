import 'package:cf_tube/const/api.dart';
import 'package:cf_tube/model/video_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class YoutubeRepository {

  static Future<List<VideoModel>> getVideos() async {
    final response = await Dio().get(
      URL,
      queryParameters: {
        "channelId": CF_CHANNEL_ID,
        "maxResults": 50,
        "key": dotenv.env["API_KEY"],
        "part": "snippet",
        "order": "date"
      }
    );

    final listWithData = response.data["items"].where((item) => // null값이면 다 제거
    item?["id"]?["videoId"] != null && item?["snippet"]?["title"] != null);

    return listWithData // <VideoModel>을 설정하지 않으면 List<dynamic>으로 설정된다.
        .map<VideoModel>((data) => VideoModel(id: data["id"]["videoId"], title: data["snippet"]["title"]))
        .toList();
  }
}