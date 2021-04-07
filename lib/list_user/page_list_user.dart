import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:tugas_akhir_flutter/model/model_user.dart';
import '../list_user/detail_list_user.dart';

class PageListUser extends StatefulWidget {
  @override
  _PageListUserState createState() => _PageListUserState();
}

class _PageListUserState extends State<PageListUser> {
  //Membuat list dari model
  List<ModelUsers> listModel = [];
  var loading = false;

  Future<Null> getData() async {
    setState(() {
      loading = true;
    });

    String url = "https://jsonplaceholder.typicode.com/users";
    final responseData = await http.get(Uri.parse(url));

    if (responseData.statusCode == 200) {
      final data = jsonDecode(responseData.body);
      setState(() {
        for (Map i in data) {
          listModel.add(ModelUsers.fromJson(i));
        }
        loading = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "List User",
            style: TextStyle(color: Colors.white),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.exit_to_app, color: Colors.white),
              onPressed: () {},
            )
          ],
        ),
        body: Container(
            child: loading
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: listModel.length,
                    itemBuilder: (context, i) {
                      final nDataList = listModel[i];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DetailListUser(nDataList)));
                        },
                        child: Container(
                          child: Card(
                            margin: EdgeInsets.all(8.0),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    nDataList.name,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0,
                                        color: Colors.lightBlue),
                                  ),
                                  Text(nDataList.phone),
                                  Text(nDataList.website),
                                  Text(nDataList.company.name)
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )));
  }
}
