import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:scheduler/database/drift_database.dart';
import 'package:scheduler/firebase_options.dart';
import 'package:scheduler/provider/schedule_provider.dart';
import 'package:scheduler/repository/schedule_repository.dart';
import 'package:scheduler/screen/home_screen.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // 플러터 프레임 워크 준비

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await initializeDateFormatting(); // intl 패키지 초기화 (다국어화)

  final database = LocalDatabase();

  GetIt.I.registerSingleton<LocalDatabase>(database); // GetIt: 의존성 주입을 구현하여 프로젝트 전역에서 사용 가능하도록
  final repository = ScheduleRepository();
  final scheduleProvider = ScheduleProvider(repository: repository);
  runApp(
      ChangeNotifierProvider(
        create: (_) => scheduleProvider,
        child: const MyApp(),
      )
  );
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}