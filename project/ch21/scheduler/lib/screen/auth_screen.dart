import 'package:calendar_scheduler/component/login_text_field.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget{
  const AuthScreen({super.key});

  @override
  State<StatefulWidget> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 60.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset('assets/img/logo.png'),
            const SizedBox(height: 16,),
            // 아이디
            LoginTextField(
              onSaved: (_) => {},
              validator: (_) => null,
              hintText: "이메일",
            ),
            const SizedBox(height: 8,),
            // 비밀번호
            LoginTextField(
              onSaved: (_) => {},
              validator: (_) => null,
              obscureText: true,
              hintText: "비밀번호",
            ),
            const SizedBox(height: 16,),
            ElevatedButton(
              onPressed: () => {},
              child: Text("로그인"),
            ),
            TextButton(
              onPressed: () => {},
              child: Text("회원 가입"),
            )
          ],
        ),
      ),
    );
  }
}