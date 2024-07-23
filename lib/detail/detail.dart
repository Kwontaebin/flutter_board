import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_board/design.dart';
import 'package:flutter_board/detail/update.dart';
import 'package:flutter_board/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({
    super.key,
    required this.id,
  });

  final String id;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late String id = widget.id;
  late int userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: const Text(
          "Flutter",
          style: appbarTitle,
        ),
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              _moveUpdatePage();
            },
            icon: const Icon(Icons.update),
          ),
        ],
      ),
      body: postWidget(),
    );
  }

  Widget postWidget() {
    final size = MediaQuery.of(context).size;
    final width90 = size.width * 0.9;

    return FutureBuilder(
      future: _fetch(),
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: snap.data!.length,
            itemBuilder: (context, index) {
              return SizedBox(
                width: double.infinity,
                height: 800,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: width90,
                      height: 100,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          snap.data[0]['title'],
                          style: detailPageTitleText,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: SizedBox(
                        width: width90,
                        height: 500,
                        child: TextField(
                          controller: TextEditingController(
                              text: '${snap.data[0]['context']}'),
                          readOnly: true,
                          maxLines: 20, // 최대 줄 수 설정
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black), // 활성화되지 않은 상태의 테두리
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black), // 포커스 시의 테두리
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }

  void failMoveUpdatePage() {
    Fluttertoast.showToast(
      msg: "게시글을 직접 작성한 사용자만 들어갈 수 있습니다.",  // 표시할 메시지
      toastLength: Toast.LENGTH_LONG,  // 토스트 메시지 길이
      gravity: ToastGravity.CENTER,  // 토스트 메시지 위치
      timeInSecForIosWeb: 1,  // iOS와 웹에서의 표시 시간
      backgroundColor: Colors.red,  // 배경 색상
      textColor: Colors.white,  // 텍스트 색상
      fontSize: 16.0,  // 폰트 크기
    );
  }

  void _moveUpdatePage() async {
    if(userId == context.read<IdProvider>().id) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              UpdatePage(id: id),
        ),
      );
    } else {
      failMoveUpdatePage();
    }
  }

  Future _fetch() async {
    var res = await http.get(Uri.parse("http://localhost:4000/getBoard/$id"));
    userId = json.decode(res.body)[0]['user_id'];
    return json.decode(res.body);
  }
}