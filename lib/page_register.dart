import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:tugas_akhir_flutter/page_login.dart';

class PageRegister extends StatefulWidget {
  @override
  _PageRegisterState createState() => _PageRegisterState();
}

class _PageRegisterState extends State<PageRegister> {
  TextEditingController cUsername = TextEditingController();
  TextEditingController cFullName = TextEditingController();
  TextEditingController cEmail = TextEditingController();
  TextEditingController cPassword = TextEditingController();
  TextEditingController cAlamat = TextEditingController();

  //deklarasi untuk masing-masing widget
  String nUsername, nFullName, nEmail, nPassword, nAlamat;
  String sex = "";

  //menambahkan key form
  final _keyForm = GlobalKey<FormState>();

  void pilihSex(String value) {
    setState(() {
      sex = value;
    });
  }

  //saat user klik tombol register
  checkForm() {
    final form = _keyForm.currentState;
    if (form.validate()) {
      form.save();
      submitDataRegister();
    }
  }

  //submit data register
  submitDataRegister() async {
    final msg = {
      "username": nUsername,
      "full_name": nFullName,
      "email": nEmail,
      "password": nPassword,
      "sex": sex,
      "alamat": nAlamat
    };
    var url = "https://drsync69.000webhostapp.com/flutter_TA/register.php";
    final responseData = await http.post(Uri.parse(url), body: msg);
    final data = jsonDecode(responseData.body);
    int value = data['value'];
    String pesan = data['message'];

    //cek value 1 atau 0
    if (value == 1) {
      setState(() {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => PageLogin()));
      });
    } else if (value == 2) {
      print(pesan);
    } else {
      print(pesan);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          key: _keyForm,
          child: ListView(
            children: <Widget>[
              Text(
                '',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 26.0,
                    color: Colors.brown),
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
                  controller: cUsername,
                  validator: (value) {
                    //cek kalau value nya kosong
                    if (value.isEmpty) {
                      return 'Please Input UserName';
                    }
                    return null;
                  },
                  onSaved: (value) => nUsername = cUsername.text,
                  decoration: InputDecoration(
                      hintText: 'username',
                      labelText: 'Input usermame',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      )),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: cFullName,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please Input Full Name';
                    }
                    return null;
                  },
                  onSaved: (value) => nFullName = cFullName.text,
                  decoration: InputDecoration(
                      hintText: 'FullName',
                      labelText: 'Input Full Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      )),
                ),
              ),

              Padding(
                padding: EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: cEmail,
                  validator: (value) {
                    //cek kalau value nya kosong
                    if (value.isEmpty) {
                      return 'Please Input Email';
                    }
                    return null;
                  },
                  onSaved: (value) => nEmail = cEmail.text,
                  decoration: InputDecoration(
                      hintText: 'Email',
                      labelText: 'Input Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      )),
                ),
              ),

              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: cPassword,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please Input Password';
                    }
                    return null;
                  },
                  onSaved: (value) => nPassword = cPassword.text,
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: 'Password',
                      labelText: 'Input Password',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0))),
                ),
              ),

              //RadioButton
              Padding(
                padding: EdgeInsets.all(10),
                child: RadioListTile(
                  value: "Laki-laki",
                  title: Text('Laki-laki'),
                  groupValue: sex,
                  onChanged: (String value) {
                    pilihSex(value);
                  },
                  activeColor: Colors.blueGrey,
                  selected: true,
                  subtitle: Text('Pilih ini jika laki-laki'),
                ),
              ),

              //RadioButton
              Padding(
                padding: EdgeInsets.all(10),
                child: RadioListTile(
                  value: "Perempuan",
                  title: Text('Perempuan'),
                  groupValue: sex,
                  onChanged: (String value) {
                    pilihSex(value);
                  },
                  activeColor: Colors.blueGrey,
                  selected: true,
                  subtitle: Text('Pilih ini jika perempuan'),
                ),
              ),

              Padding(
                padding: EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: cAlamat,
                  validator: (value) {
                    //cek kalau value nya kosong
                    if (value.isEmpty) {
                      return 'Please Input Alamat';
                    }
                    return null;
                  },
                  maxLines: 3,
                  onSaved: (value) => nAlamat = cAlamat.text,
                  decoration: InputDecoration(
                      hintText: 'Alamat',
                      labelText: 'Input Alamat',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      )),
                ),
              ),

              Padding(
                padding: EdgeInsets.fromLTRB(10.0, 40.0, 10.0, 0),
                child: MaterialButton(
                  color: Colors.blueGrey,
                  textColor: Colors.white,
                  child: Text('Register'),
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
                  child: Text('Sudah Punya Akun ? Silahkan Login'),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => PageLogin()));
                  },
                ),
              )
            ],
          )),
    );
  }
}
