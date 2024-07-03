import 'package:calendar_scheduler/component/login_text_field.dart';
import 'package:calendar_scheduler/database/drift_database.dart';
import 'package:calendar_scheduler/provider/schedule_provider.dart';
import 'package:calendar_scheduler/screen/home_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget{
  const AuthScreen({super.key});

  @override
  State<StatefulWidget> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

  GlobalKey<FormState> key = GlobalKey();

  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ScheduleProvider>();
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 60.0),
        child: Form(
          key: key,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset('assets/img/logo.png'),
              const SizedBox(height: 16,),
              // 아이디
              LoginTextField(
                onSaved: (val) => email = val!,
                validator: emailValidator,
                hintText: "이메일",
              ),
              const SizedBox(height: 8,),
              // 비밀번호
              LoginTextField(
                onSaved: (val) => email = val!,
                validator: passwordValidator,
                obscureText: true,
                hintText: "비밀번호",
              ),
              const SizedBox(height: 16,),
              ElevatedButton(
                onPressed: () => onLogin(provider),
                child: Text("로그인"),
              ),
              TextButton(
                onPressed: () => onRegister(provider),
                child: Text("회원 가입"),
              )
            ],
          ),
        ),
      ),
    );
  }

  String? emailValidator(String? val) {
    if (val?.isEmpty ?? true) {
      return "이메일을 입력해주세요";
    }

    RegExp regExp = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

    if (!regExp.hasMatch(val!)) {
      return "이메일이 올바르지 않습니다.";
    }

    return null;
  }

  String? passwordValidator(String? val) {
    if (val?.isEmpty ?? true) {
      return "비밀 번호를 입력해주세요.";
    }

    if (val!.length < 8) {
      return "비밀 번호의 길이가 짧습니다.";
    }

    return null;
  }

  bool saveAndValidate() {
    if (!key.currentState!.validate()) {
      return false;
    }

    key.currentState!.save();
    return true;
  }

  onRegister(ScheduleProvider provider) async {
    if (!saveAndValidate()) {
      return;
    }

    String? message;

    try {
      final response = await provider.register(email: email, password: password);
    } on DioError catch (e) {
      message = e.response?.data['message'] ?? "알 수 없는 에러입니다.";
    } catch (e) {
      message = "알 수 없는 에러입니다.";
    }

    if (message != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        )
      );
    }
    else {
      Navigator.of(context).push(
          MaterialPageRoute(
              builder: (_) => HomeScreen()
          )
      );
    }
  }

  onLogin(ScheduleProvider provider) async {
    if (!saveAndValidate()) {
      return;
    }

    String? message;

    try {
      await provider.login(email: email, password: password);
    } on DioError catch(e) {
      e.response?.data['message'] ?? "알 수 없는 에러입니다.";
    } catch(e) {
      message = "알 수 없는 에러입니다.";
    }

    if (message != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        )
      );
    }
    else {
      Navigator.of(context).push(
        MaterialPageRoute(
            builder: (_) => HomeScreen()
        )
      );
    }
  }

}