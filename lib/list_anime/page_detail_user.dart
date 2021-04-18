import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailUser extends StatefulWidget {
  @override
  _DetailUserState createState() => _DetailUserState();
}

class _DetailUserState extends State<DetailUser> {
  String email = "";
  String alamat = "";
  String username = "";
  String jekel = "";
  String full_name = "";
  String idUser;
  getDataPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      username = sharedPreferences.getString("username");
      email = sharedPreferences.getString("alamat");
      full_name = sharedPreferences.getString("full_name");
      email = sharedPreferences.getString("email");
      alamat = sharedPreferences.getString("alamat");
      jekel = sharedPreferences.getString("sex");
      idUser = sharedPreferences.getString("id_user");
    });
  }

  @override
  void initState() {
    getDataPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail User',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 80.0,
                  ),
                  Text(
                    full_name,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors.lightBlue),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Email",
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  Text(email),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    "Jenis Kelamin",
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  Text(jekel),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    "Alamat",
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  Text(alamat),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
