// ignore_for_file: prefer_const_constructors

import 'package:data_app/views/product/detail/list/product_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// spring는 db에 연결된 repository와 연결
// flutter의 repository는 spring의 서버와 연결이 된다. 헷갈리면 안된다!

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

final navigatorKey = GlobalKey<NavigatorState>(); // 해당 화면의 뷰를 찾아준다.

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      home: ProductListView(),
    );
  }
}
