import 'package:flutter/material.dart';
import 'package:flutter_board/home/home.dart';
import 'package:flutter_board/login_sign/sign.dart';
import 'package:flutter_board/post/post.dart';
import 'package:provider/provider.dart';
import 'provider.dart';
import 'login_sign/login.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => IdProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "flutter_note",
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => const LoginPage(),
        '/sign': (BuildContext context) => const SignPage(),
        '/home': (BuildContext context) => const HomePage(),
        '/post': (BuildContext context) => const PostPage(),
      },
    );
  }
}
