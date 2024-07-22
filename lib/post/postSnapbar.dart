import 'package:flutter/material.dart';

void nullTitle(BuildContext context) {
  final snackBar = SnackBar(
    content: const Text('제목을 입력하세요'),
    action: SnackBarAction(
      label: '확인',
      onPressed: () {},
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}


void nullContext(BuildContext context) {
  final snackBar = SnackBar(
    content: const Text("본문을 입력하세요"),
    action: SnackBarAction(
      label: '확인',
      onPressed: () {},
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void postSuccess(BuildContext context) {
  final snackBar = SnackBar(
    content: const Text("게시글 작성 성공"),
    action: SnackBarAction(
      label: '확인',
      onPressed: () {},
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
