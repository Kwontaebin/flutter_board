import 'package:flutter/material.dart';

const appbarTitle = TextStyle(
  fontSize: 25,
  decoration: TextDecoration.none,
  fontWeight: FontWeight.bold,
  height: 10 / 10,
  color: Colors.white,
);

final basicButton = ElevatedButton.styleFrom(
  backgroundColor: const Color.fromARGB(255, 149, 81, 222),
  minimumSize: const Size(400, 65),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(50),
  ),
  elevation: 0.0,
);

final postButton = ElevatedButton.styleFrom(
  backgroundColor: const Color.fromARGB(255, 6, 103, 248),
  minimumSize: const Size(350, 45),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10),
  ),
  elevation: 0.0,
);

const basicButtonText = TextStyle(
  fontSize: 20,
  decoration: TextDecoration.none,
  fontWeight: FontWeight.bold,
  height: 10 / 10,
  color: Colors.white,
);

const postListId = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w700,
  color: Colors.black,
);

const postListName = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.w500,
  color: Colors.black
);

const postListHeader = TextStyle(
  fontSize: 25,
  fontWeight: FontWeight.w900,
  color: Colors.black,
);

const postListFooterText = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w600,
  color: Colors.black,
);

const detailPageTitleText = TextStyle(
  fontSize: 25,
  fontWeight: FontWeight.w700,
  color: Colors.black
);