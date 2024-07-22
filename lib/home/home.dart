import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_board/design.dart';
import 'package:provider/provider.dart';
import '../provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future _fetch() async {
    var res = await http.get(Uri.parse("http://localhost:4000/getBoard"));
    return json.decode(res.body);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetch();
  }

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
        leading: IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () {
            _logout(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.post_add),
            onPressed: () {
              Navigator.pushNamed(context, '/post');
            },
          ),
        ],
      ),
      body: const SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,

          ),
        ),
    );
  }

  void _logout(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('확인'),
          content: const Text('로그아웃하시겠습니까?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                context.read<IdProvider>().setId(0, "", 0);
                Navigator.pushNamed(context, '/');
              },
              child: const Text('확인'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 취소 버튼 클릭 시 다이얼로그 닫기
              },
              child: const Text('취소'),
            ),
          ],
        );
      },
    );
  }

  Widget postList() {
    return FutureBuilder(
      future: _fetch(), // 비동기 함수(JSON 수신 등)
      builder: (context, snap) {
        // CircularProgressIndicator: 데이터가 들어오지 않으면 원이 빙글빙글 돌면서 값이 들어오기를 기다린다.
        if (!snap.hasData) return const CircularProgressIndicator();
        return ListView.builder(
          itemCount: snap.data.length,
          itemBuilder: (BuildContext context, int index) {
            return const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,

            );
          },
        );
      },
    );
  }
}
