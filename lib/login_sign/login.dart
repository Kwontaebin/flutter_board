import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_board/login_sign/snapbar.dart';
import 'package:provider/provider.dart';
import '../design.dart';
import 'package:http/http.dart' as http;
import '../provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String id = "";
  String pw = "";
  List<dynamic> data = [];
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width90 = size.width * 0.9;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: const Text(
          'Flutter',
          style: appbarTitle,
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: SizedBox(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 150),
                  child: SizedBox(
                    width: width90,
                    child: TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "아이디를 입력해주세요",
                        hintText: '아이디 입력',
                        // 회원가입에서 사용
                        // helperText: "@를 사용해서 이메일 형식으로 작성해주세요",
                      ),
                      onChanged: (value) {
                        setState(() {
                          id = value;
                        });
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: SizedBox(
                    width: width90,
                    child: TextField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "비밀번호를 입력해주세요",
                        hintText: '비밀번호 입력',
                        // 회원가입에서 사용
                        // helperText: "@를 사용해서 이메일 형식으로 작성해주세요",
                      ),
                      onChanged: (value) {
                        setState(() {
                          pw = value;
                        });
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 150),
                  child: ElevatedButton(
                    style: basicButton,
                    onPressed: () {
                      setState(() {
                        loginFn();
                        // 여기에 provider id 저장 코드를 넣는다.
                      });
                    },
                    child: const Text(
                      "로그인",
                      style: basicButtonText,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 200),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/sign');
                    },
                    child: const Text(
                      "회원가입을 하지 않으셨나요?",
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void loginFn() async {
    var res = await http.get(Uri.parse("http://localhost:4000/getAllUser"));
    String loginStatus = "";
    late int loginId;
    late String loginName;

    if (res.statusCode == 200) {
      setState(() {
        data = json.decode(res.body);
      });
    }

    for (int i = 0; i < data.length; i++) {
      if (data[i]['user_id'] == id) {
        if (data[i]["user_pw"] == pw) {
          loginStatus = "success";
          loginId = data[i]['id'];
          loginName = data[i]['user_name'];
          break;
        } else {
          loginStatus = "pwErr";
          break;
        }
      } else {
        loginStatus = "idErr";
      }
    }

    if (loginStatus == "idErr") {
      loginIdErr(context);
    } else if (loginStatus == "pwErr") {
      loginPwErr(context);
    } else if (loginStatus == "success") {
      context.read<IdProvider>().setId(loginId, loginName, 0);
      loginSuccess(context);

      Navigator.pushNamed(context, '/home');
    }
  }
}
