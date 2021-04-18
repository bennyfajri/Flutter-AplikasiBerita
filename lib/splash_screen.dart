import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tugas_akhir_flutter/list_anime/page_list_anime.dart';
import 'package:tugas_akhir_flutter/page_login.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.lightBlue,
          body: Center(
            child: Image.asset("assets/splash.png"),
          )),
      debugShowCheckedModeBanner: false,
    );
  }

  Future<Timer> startTimer() async {
    return Timer(Duration(seconds: 3), onDone);
  }

  void onDone() {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => PageLogin()));
  }
}
