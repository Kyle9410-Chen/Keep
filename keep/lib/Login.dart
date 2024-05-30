import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keep/APIRequest.dart';
import 'dart:convert';

import 'package:keep/main.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({super.key});
  @override
  State<StatefulWidget> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: TextField(
              controller: username,
              decoration: const InputDecoration(
                  hintText: "Username",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 2,
                        color: Colors.blue
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 3,
                        color: Colors.blue
                    ),
                  )
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: TextField(
              controller: password,
              decoration: const InputDecoration(
                  hintText: "Password",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 2,
                        color: Colors.blue
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 3,
                        color: Colors.blue
                    ),
                  )
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: TextButton(
                onPressed: () {
                  var res = UserRequest.login({ "account" : username.text, "password" : password.text});
                  res.then((value){
                    var jsonData = json.decode(value);
                    if (jsonData["state"].toString() == "success"){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
                          MainPage(int.parse(jsonData["id"].toString()), jsonData["res"])
                      ));
                    }
                  });
                },
                child: Text("Login", style: TextStyle(fontSize: 18)),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]);
    super.initState();


  }
}

