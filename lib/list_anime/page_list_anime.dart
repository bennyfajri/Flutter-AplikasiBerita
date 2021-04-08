import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugas_akhir_flutter/model/model_anime.dart';
import 'package:http/http.dart' as http;
import 'package:tugas_akhir_flutter/model/model_user.dart';
import 'package:tugas_akhir_flutter/page_login.dart';

class ListAnime extends StatefulWidget {
  // final VoidCallback signOut;
  // ListAnime(this.signOut);

  @override
  _ListAnimeState createState() => _ListAnimeState();
}

class _ListAnimeState extends State<ListAnime> {
  List<ModelUsers> listDataAnime = [];
  var loading = false;

  //proses get data on background
  Future<Null> getData() async {
    setState(() {
      loading = true;
    });

    var url = "https://jsonplaceholder.typicode.com/users";
    final responseData = await http.get(Uri.parse(url));

    //cek status response
    if (responseData.statusCode == 200) {
      final data = jsonDecode(responseData.body);
      setState(() {
        for (Map i in data) {
          //menambahkan data yang sudah nerhasil di get ke list model
          listDataAnime.add(ModelUsers.fromJson(i));
        }
        loading = false;
      });
    }
  }

  // tambahan method signout
  signOut() async {
    setState(() {
      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  //mengambil nilai dari shared preferences
  String username = "";
  String fullname = "";
  getDataPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      username = sharedPreferences.getString("username");
      fullname = sharedPreferences.getString("fullname");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hi, " + username),
        automaticallyImplyLeading: false,
        //menghilangkan tombol back
        backgroundColor: Colors.lightBlue,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.exit_to_app, color: Colors.white),
              onPressed: () {
                signOut();
              })
        ],
      ),
      body: Container(
          child: loading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: listDataAnime.length,
                  itemBuilder: (context, index) {
                    final nDataList = listDataAnime[index];
                    return Card(
                      margin: EdgeInsets.all(5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(nDataList.name,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                  color: Colors.lightBlue)),
                        ],
                      ),
                    );
                  },
                )),
    );
  }
}
