import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugas_akhir_flutter/list_anime/page_list_anime.dart';
import 'package:tugas_akhir_flutter/page_home.dart';
import 'package:tugas_akhir_flutter/page_register.dart';

class PageLogin extends StatefulWidget {
  @override
  _PageLoginState createState() => _PageLoginState();
}

enum statusLogin { signIn, notSignIn }

class _PageLoginState extends State<PageLogin> {
  TextEditingController username = new TextEditingController();
  TextEditingController password = new TextEditingController();

  statusLogin _loginStatus = statusLogin.notSignIn;
  final _keyForm = GlobalKey<FormState>();
  String nUsername, nPassword;

  checkForm() {
    final form = _keyForm.currentState;
    if (form.validate()) {
      form.save();
      submitDataLogin();
    }
  }

  //mengirim request dan menanggapinya
  submitDataLogin() async {
    final msg = {'username': nUsername, 'password': nPassword};
    var url = "https://drsync69.000webhostapp.com/flutter_TA/login.php";
    final responsData = await http.post(Uri.parse(url), body: msg);

    final data = jsonDecode(responsData.body);
    int value = data['value'];
    String pesan = data['message'];
    print(data);

    //get data respon
    String dataUsername = data['username'];
    String dataEmail = data['email'];
    String dataAlamat = data['alamat'];
    String dataSex = data['sex'];
    String dataFullname = data['full_name'];
    String dataTanggalDaftar = data['tgl_daftar'];
    String dataIdUser = data['id_user'];

    // cek value 1 atau 0
    if (value == 1) {
      setState(() {
        // set status loginnya sebagai login
        _loginStatus = statusLogin.signIn;

        // simpan data ke share preferences
        saveDataPref(value, dataIdUser, dataUsername, dataEmail, dataAlamat,
            dataSex, dataFullname, dataTanggalDaftar);
      });
    } else if (value == 2) {
      print(pesan);
    } else {
      print(pesan);
    }
  }

  // method untuk simpan share pref
  saveDataPref(int value, String dIdUser, dUsername, dEmail, dAlamat, dSex,
      dFullName, dCreated) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      sharedPreferences.setInt("value", value);
      sharedPreferences.setString("username", dUsername);
      sharedPreferences.setString("id_user", dIdUser);
      sharedPreferences.setString("email", dEmail);
      sharedPreferences.setString("alamat", dAlamat);
      sharedPreferences.setString("sex", dSex);
      sharedPreferences.setString("full_name", dFullName);
      sharedPreferences.setString("tgl_daftar", dCreated);
    });
  }

  /*
Method ini digunakan untuk mengecek apakah user sudah login atau belum
jika sudah set valuenya
  */

  getDataPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      int nvalue = sharedPreferences.getInt("value");
      _loginStatus = nvalue == 1 ? statusLogin.signIn : statusLogin.notSignIn;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getDataPref();
    super.initState();
  }

  //Method untuk sign Out
  SignOut() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      sharedPreferences.setInt("value", null);
      sharedPreferences.commit();
      _loginStatus = statusLogin.notSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (_loginStatus) {
      case statusLogin.notSignIn:
        return Scaffold(
          backgroundColor: Colors.white,
          body: Form(
            key: _keyForm,
            child: ListView(
              children: <Widget>[
                Center(
                  child: Text(
                    'Login Form',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 26.0,
                        color: Colors.brown),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Image.asset(
                  'assets/splash.png',
                  height: 100.0,
                  width: 100.0,
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: username,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Input Username';
                      }
                      return null;
                    },
                    onSaved: (value) => nUsername = value,
                    decoration: InputDecoration(
                        hintText: 'Username',
                        labelText: 'Input Username',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    controller: password,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please input password';
                      }
                      return null;
                    },
                    onSaved: (value) => nPassword = value,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      labelText: 'Input Password',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10.0, 40.0, 10.0, 0),
                  child: MaterialButton(
                    color: Colors.lightBlue,
                    textColor: Colors.white,
                    child: Text('Login'),
                    onPressed: () {
                      setState(() {
                        checkForm();
                      });
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0),
                  child: MaterialButton(
                    textColor: Colors.blueGrey,
                    child: Text('Belum Punya Akun ? Silahkan Daftar'),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PageRegister()));
                    },
                  ),
                )
              ],
            ),
          ),
        );

        break;
      case statusLogin.signIn:
        return ListAnime();
        break;
    }
  }
}
