import 'package:flutter/material.dart';

void nullTextField(BuildContext context) {
  final snackBar = SnackBar(
    content: const Text('전부다 입력하세요'),
    action: SnackBarAction(
      label: '확인',
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

// 비밀번호와 비밀번호 확인이 일치하지 않을 경우
void pwAgreementCheckPw(BuildContext context) {
  final snackBar = SnackBar(
    content: const Text('비밀번호가 일치하지 않습니다.'),
    action: SnackBarAction(
      label: '확인',
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void agreementId(BuildContext context) {
  final snackBar = SnackBar(
    content: const Text('중복되는 아이디가 있습니다.'),
    action: SnackBarAction(
      label: '확인',
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void agreementName(BuildContext context) {
  final snackBar = SnackBar(
    content: const Text('중복되는 이름이 있습니다.'),
    action: SnackBarAction(
      label: '확인',
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void loginIdErr(BuildContext context) {
  final snackBar = SnackBar(
    content: const Text('아이디가 일치하지 않습니다.'),
    action: SnackBarAction(
      label: '확인',
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void loginPwErr(BuildContext context) {
  final snackBar = SnackBar(
    content: const Text('비밀번호가 일치하지 않습니다.'),
    action: SnackBarAction(
      label: '확인',
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void loginSuccess(BuildContext context) {
  final snackBar = SnackBar(
    content: const Text('로그인 성공'),
    action: SnackBarAction(
      label: '확인',
      onPressed: () {},
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
