import 'dart:io';

import 'package:dio/dio.dart';
import 'package:scheduler/model/schedule_model.dart';

class ScheduleRepository {
  final _dio = Dio();
  final _url = "http://${Platform.isAndroid ? '10.0.2.2' : 'localhost'}:3000/schedule";

  Future<List<ScheduleModel>> getSchedules({required DateTime date}) async {
    final resp = await _dio.get(
      _url,
      queryParameters: {
        'date':
            '${date.year}${date.month.toString().padLeft(2, '0')}${date.day.toString().padLeft(2, '0')}'
      },
    );

    return resp.data.map<ScheduleModel>(
        (x) => ScheduleModel.fromJson(
            json: x
        )
    ).toList();
  }

  Future<String> createSchedule({required ScheduleModel model}) async {
    final resp = await _dio.post(
      _url,
      data: model.toJson(),
    );
    return resp.data?['id'];
  }

  Future<String> deleteSchedule({required String id }) async {
    final resp = await _dio.delete(
      _url,
      data: {
        'id': id
      }
    );

    return resp.data?['id'];
  }
}