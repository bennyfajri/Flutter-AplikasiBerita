import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugas_akhir_flutter/list_anime/page_detail_anime.dart';
import 'package:tugas_akhir_flutter/model/model_anime.dart';
import 'package:http/http.dart' as http;

class ListAnime extends StatefulWidget {
  // final VoidCallback signOut;
  // ListAnime(this.signOut);

  @override
  _ListAnimeState createState() => _ListAnimeState();
}

class _ListAnimeState extends State<ListAnime> {
  List<ModelAnime> listDataAnime = [];

  var loading = false;

  //proses get data on background
  Future<ModelAnime> getData() async {
    ModelAnime models = new ModelAnime();
    setState(() {
      loading = true;
    });

    // var url = "https://ghibliapi.herokuapp.com/films/";
    var url =
        "https://private-anon-ec9cc7f5fa-jikan.apiary-proxy.com/v3/genre/anime/1/1";
    final responseData = await http.get(Uri.parse(url));

    //cek status response
    if (responseData.statusCode == 200 || json != null) {
      Map jsonParsed = jsonDecode(responseData.body);
      models = ModelAnime.fromJson(jsonParsed);
      return models;
      // final data = jsonDecode(responseData.body);

      setState(() {
        //menambahkan data yang sudah berhasil di get ke list model
        // for (Map i in data) {
        // listDataAnime.add(ModelAnime.fromJson(data));
        // }

        loading = false;
      });
    } else {
      print("Request failed with status: ${responseData.statusCode}");
      throw Exception('Failed to load post');
    }
  }

  // tambahan method signout
  signOut() async {
    setState(() {
      // widget.signOut();
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

  detailUser() async {
    Navigator.push(context, detailUser());
  }

  @override
  void initState() {
    super.initState();
    getData();
    getDataPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Hi ' + username,
            style: TextStyle(color: Colors.white),
          ),
          //delete tombol back
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.supervised_user_circle_outlined,
                    color: Colors.white),
                onPressed: () {
                  detailUser();
                }),
            IconButton(
                icon: Icon(Icons.exit_to_app, color: Colors.white),
                onPressed: () {
                  signOut();
                })
          ],
        ),
        body: Center(
          child: FutureBuilder<ModelAnime>(
            future: getData(),
            builder: (context, listData) {
              if (listData.hasData) {
                return
                    //Center(child:Text(snapshot.data.items[0].id) ,);
                    ListView.builder(
                  itemCount: listData.data.anime.length,
                  itemBuilder: (context, int i) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DetailListFilm(listData.data)));
                      },
                      child: Container(
                          child: Card(
                        margin: EdgeInsets.fromLTRB(8, 4, 8, 4),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              ListTile(
                                leading: Image.network(
                                    listData.data.anime[i].imageUrl),
                                title: Text(
                                  listData.data.anime[i].title,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.lightBlue),
                                ),
                                subtitle: Text(
                                  listData.data.anime[i].synopsis,
                                  maxLines: 2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                    );
                  },
                );
              } else if (listData.hasError) {
                return Center(
                  child: Text("${listData.error}"),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ));
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text("Hi, " + username),
  //       automaticallyImplyLeading: false,
  //       //menghilangkan tombol back
  //       backgroundColor: Colors.lightBlue,
  //       actions: <Widget>[
  //         IconButton(
  //             icon: Icon(Icons.exit_to_app, color: Colors.white),
  //             onPressed: () {
  //               signOut();
  //             })
  //       ],
  //     ),
  //     body: Container(
  //         child: loading
  //             ? Center(child: CircularProgressIndicator())
  //             : ListView.builder(
  //                 itemCount: listDataAnime.length,
  //                 itemBuilder: (context, index) {
  //                   final nDataList = listDataAnime[index];
  //                   // final rank = nDataList.top.rank;
  //                   return InkWell(
  //                     onTap: () {
  //                       Navigator.push(
  //                           context,
  //                           MaterialPageRoute(
  //                               builder: (context) => DetailListFilm()));
  //                     },
  //                     child: Container(
  //                       child: Card(
  //                         margin: EdgeInsets.all(4.0),
  //                         child: Padding(
  //                           padding: const EdgeInsets.all(16.0),
  //                           child: Column(
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: <Widget>[
  //                               Text(
  //                                 nDataList.requestHash,
  //                                 style: TextStyle(
  //                                     fontWeight: FontWeight.bold,
  //                                     color: Colors.lightBlue,
  //                                     fontSize: 16.0),
  //                               ),
  //                               SizedBox(height: 4.0),
  //                               Text(
  //                                 "Score: ",
  //                                 style: TextStyle(
  //                                   fontWeight: FontWeight.bold,
  //                                   color: Colors.black,
  //                                 ),
  //                               )
  //                             ],
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   );
  //                 },
  //               )),
  //   );
  // }
}
