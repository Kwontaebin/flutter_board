import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_board/design.dart';
import 'package:http/http.dart' as http;

class UpdatePage extends StatefulWidget {
  const UpdatePage({super.key, required this.id});

  final String id;

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  late String id = widget.id;

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
      ),
      body: updatePost(),
    );
  }

  Widget updatePost() {
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
              return const SizedBox(
                width: double.infinity,
                height: 800,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                  ],
                ),
              );
            },
          );
        }
      },
    );
  }

  Future _fetch() async {
    var res = await http.get(Uri.parse("http://localhost:4000/getBoard/$id"));
    return json.decode(res.body);
  }
}
