import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_board/design.dart';
import 'package:flutter_board/post/postSnapbar.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../provider.dart'; // 디자인 스타일 임포트

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  String title = "";
  String contextBoard = "";

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width90 = size.width * 0.9;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: const Text(
          "Flutter",
          style: appbarTitle,
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: SizedBox(
                width: width90,
                child: TextField(
                  decoration: const InputDecoration(
                    labelText: '제목을 입력하세요',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(12.0), // 내부 패딩 설정
                  ),

                  onChanged: (value) => {
                    title = value,
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: SizedBox(
                width: width90,
                height: 400.0,
                child: TextField(
                  maxLines: 10, // 최대 줄 수 설정
                  decoration: const InputDecoration(
                    labelText: '본문을 입력하세요',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(12.0), // 내부 패딩 설정
                  ),

                  onChanged: (value) => {
                    contextBoard = value,
                  },
                ),
              ),
            ),
            ElevatedButton(
              style: postButton,
              onPressed: () {
                setState(() {
                  postBoardFn();
                });
              },
              child: const Text(
                "게시글 작성",
                style: basicButtonText,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> postBoard() async {
    var url = Uri.parse("http://localhost:4000/postBoard");
    final idProvider = context.read<IdProvider>();
    print(idProvider.id);
    print(idProvider.name);

    var data = {
      "user_id": idProvider.id,
      "user_name": idProvider.name,
      "title": title,
      "context": contextBoard,
    };

    var res = await http.post(
      url,
      body: json.encode(data),
      headers: {"Content-Type": "application/json"},
    );

    if (res.statusCode == 200) print('POST 성공: ${res.body}');
    Navigator.pushNamed(context, '/home');
    if (res.statusCode != 200) print('POST 실패: ${res.statusCode}');
  }

  void postBoardFn() async {
    if(title == "") {
      nullTitle(context);
      return;
    } else if(contextBoard == "") {
      nullContext(context);
      return;
    } else {
      await postBoard();
      postSuccess(context);
      return;
    }
  }
}