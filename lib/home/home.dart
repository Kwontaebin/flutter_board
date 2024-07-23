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
    int providerId = context.read<IdProvider>().id;
    String providerName = context.read<IdProvider>().name;
    int providerPageNum = context.read<IdProvider>().pageNum;

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
      body: Consumer<IdProvider>(
          builder: (context, idProvider, child) {
            return SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50, bottom: 40),
                    child: Container(
                      width: width90,
                      height: 50,
                      color: Colors.cyan,
                    ),
                  ),
                  SizedBox(
                    width: width90,
                    height: 500,
                    child: postList(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: GestureDetector(
                      onTap: () => {
                        context.read<IdProvider>().setId(
                            providerId,
                            providerName,
                            context.read<IdProvider>().pageNum + 1),
                        print(context.read<IdProvider>().pageNum),
                      },
                      child: Container(
                        width: width90,
                        height: 50,
                        color: Colors.deepPurpleAccent,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          // child: SizedBox(
          //   width: double.infinity,
          //   height: double.infinity,
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     children: [
          //       Padding(
          //         padding: const EdgeInsets.only(top: 50, bottom: 40),
          //         child: Container(
          //           width: width90,
          //           height: 50,
          //           color: Colors.cyan,
          //         ),
          //       ),
          //       SizedBox(
          //         width: width90,
          //         height: 500,
          //         child: postList(),
          //       ),
          //       Padding(
          //         padding: const EdgeInsets.only(top: 30),
          //         child: GestureDetector(
          //           onTap: () => {
          //             context.read<IdProvider>().setId(providerId, providerName,
          //                 context.read<IdProvider>().pageNum + 1),
          //             print(context.read<IdProvider>().pageNum),
          //           },
          //           child: Container(
          //             width: width90,
          //             height: 50,
          //             color: Colors.deepPurpleAccent,
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
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
    final size = MediaQuery.of(context).size;
    final width90 = size.width * 0.9;
    final width10 = size.width * 0.1;
    final width20 = size.width * 0.2;
    final width40 = size.width * 0.35;

    return FutureBuilder(
      future: _fetch(),
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snap.hasError) {
          return Center(child: Text('Error: ${snap.error}'));
        } else if (snap.hasData) {
          return ListView.builder(
            itemCount: snap.data!.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: width90,
                      height: 100 / 2,
                      color: CupertinoColors.lightBackgroundGray,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: width10,
                            height: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10, left: 20),
                              child: Text(
                                snap.data[index]['id'].toString(),
                                style: postListId,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width20,
                            height: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 12, left: 20),
                              child: Text(
                                snap.data[index]['user_name'].toString(),
                                style: postListName,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width40,
                            height: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 12, left: 20),
                              child: Text(
                                snap.data[index]['context'].toString(),
                                style: postListName,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 100,
                            height: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 12),
                              child: Text(
                                snap.data[index]['date'].toString(),
                                style: postListName,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        } else {
          return const Center(child: Text('등록된 게시글이 없습니다.'));
        }
      },
    );
  }

  Future _fetch() async {
    var res = await http.get(Uri.parse(
        "http://localhost:4000/getBoard/${context.read<IdProvider>().pageNum}"));
    return json.decode(res.body);
  }
}
