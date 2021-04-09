import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailListUser extends StatefulWidget {
  @override
  _DetailListUserState createState() => _DetailListUserState();
}

class _DetailListUserState extends State<DetailListUser> {
  String username = "";
  String fullname = "";
  getDataPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    username = sharedPreferences.getString("username");
    fullname = sharedPreferences.getString("fullname");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail User'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: <Widget>[
              Text(
                fullname,
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              Text(
                username,
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
