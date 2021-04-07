import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../model/model_user.dart';

class DetailListUser extends StatelessWidget {
  final ModelUsers user;
  DetailListUser(this.user);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          user.name,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.lightBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    user.name,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors.lightBlue),
                  ),
                  Text(user.email),
                  Text(user.phone),
                  Text(user.website),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    "Address",
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  Text(user.address.street),
                  Text(user.address.city),
                  Text(user.address.suite),
                  Text(user.address.zipcode),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    "Company",
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  Text(user.company.name)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
