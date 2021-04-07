import 'package:flutter/material.dart';
import 'package:tugas_akhir_flutter/list_user/page_list_user.dart';
import 'package:tugas_akhir_flutter/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/list': (context) => PageListUser(),
      },
      title: 'List User',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
