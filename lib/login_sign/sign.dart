import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_board/login_sign/snapbar.dart';
import 'package:http/http.dart' as http;
import '../design.dart';

class SignPage extends StatefulWidget {
  const SignPage({super.key});

  @override
  State<SignPage> createState() => _SignPageState();
}

class _SignPageState extends State<SignPage> {
  String id = "";
  late String pw = "";
  String checkPw = "";
  String name = "";
  bool status = false;

  List<dynamic> userData = [];

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
                        labelText: "이메일을 입력해주세요",
                        hintText: '이메일 입력',
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
                  padding: const EdgeInsets.only(top: 10),
                  child: SizedBox(
                    width: width90,
                    child: TextField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "비밀번호 확인",
                        hintText: '비밀번호 확인',
                      ),
                      onChanged: (value) {
                        setState(() {
                          checkPw = value;
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
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "이름을 입력해주세요",
                        hintText: '이름 입력',
                      ),
                      onChanged: (value) {
                        setState(() {
                          name = value;
                        });
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: ElevatedButton(
                    style: basicButton,
                    onPressed: () {
                      setState(() {
                        signFn();
                      });
                    },
                    child: const Text(
                      "회원가입",
                      style: basicButtonText,
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

  Future<void> postSign() async {
    var url = Uri.parse("http://localhost:4000/addUser");
    var data = {
      "user_id": id,
      "user_pw": pw,
      "user_name": name
    }; // 이 데이터를 원하는 형식으로 구성하세요.

    var response = await http.post(
      // post하는 url주소
      url,
      body: json.encode(data),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) print('POST 성공: ${response.body}');
    Navigator.pop(context);
    if (response.statusCode != 200) print('POST 실패: ${response.statusCode}');
  }

  void signFn() async {
    var response =
        await http.get(Uri.parse("http://localhost:4000/getAllUser"));


    if (response.statusCode == 200) {
      setState(() {
        userData = json.decode(response.body);
      });
    }

    if (userData.length != 0) {
      for (int i = 0; i < userData.length; i++) {
        if (id == "" || pw == "" || checkPw == '' || name == '') {
          nullTextField(context);
          break;
        } else if (pw != checkPw) {
          pwAgreementCheckPw(context);
          break;
        } else if (userData[i]['user_id'] == id) {
          agreementId(context);
          break;
        } else if (userData[i]["user_name"] == name) {
          agreementName(context);
          break;
        } else {
          postSign();
          break;
        }
      }
    }
  }
}
