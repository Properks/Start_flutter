import 'package:calendar_scheduler/repository/auth_repository.dart';
import 'package:calendar_scheduler/screen/auth_screen.dart';
import 'package:calendar_scheduler/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:calendar_scheduler/database/drift_database.dart';
import 'package:get_it/get_it.dart';
import 'package:calendar_scheduler/provider/schedule_provider.dart';
import 'package:calendar_scheduler/repository/schedule_repository.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting();

  final authRepository = AuthRepository();
  final scheduleRepository = ScheduleRepository();
  final scheduleProvider = ScheduleProvider(authRepository: authRepository, scheduleRepository: scheduleRepository);

  runApp(
    ChangeNotifierProvider(
      create: (_) => scheduleProvider,
      child: const MyApp()
    ),
  );
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthScreen(),
    );
  }
}
