
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AuthRepository {
  final _dio = Dio();
  final _targetURL = 'http://${Platform.isAndroid ? "10.0.2.2": "localhost"}:3000/auth';

  // 회원 가입
  Future<({String refreshToken, String accessToken})> register({
    required String email,
    required String password,
  }) async {
    final response = await _dio.post(
      '$_targetURL/register/email',
      data: {
        'email': email,
        'password': password
      }
    );

    return (refreshToken: response.data!['refreshToken'] as String,
    accessToken: response.data!['accessToken'] as String);
  }

  //login
  Future<({String refreshToken, String accessToken})> login({
    required String email,
    required String password,
  }) async {
    Codec<String, String> codec = utf8.fuse(base64);
    final emailAndPassword = codec.encode('$email:$password');

    final response = await _dio.post(
      '$_targetURL/login/email',
      options: Options(
        headers: {
          'authorization': 'Basic $emailAndPassword'
        }
      )
    );

    return (refreshToken: response.data['refreshToken'] as String,
    accessToken: response.data['accessToken'] as String);
  }

  Future<String> rotateRefreshToken({
    required String refreshToken,
  }) async {
    final response = await _dio.post(
      '$_targetURL/token/refresh',
      options: Options(
        headers: {
          'authorization': 'Bearer $refreshToken'
        },
      )
    );

    return response.data['refreshToken'] as String;
  }

  Future<String> rotateAccessToken({
    required String refreshToken,
  }) async {
    final response = await _dio.post(
      '$_targetURL/token/access',
      options: Options(
        headers: {
          'authorization': 'Bearer $refreshToken'
        }
      )
    );

    return response.data['accessToken'] as String;
  }
}