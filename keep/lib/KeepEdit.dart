import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keep/APIRequest.dart';
import 'package:keep/main.dart';

import 'TextInput.dart';

class KeepEdit extends StatefulWidget{
  KeepEdit(this.data, this.userId) {
    child = _KeepEdit(data, userId);
    this.userId = userId;
  }
  KeepEdit.empty(this.userId){
    child = _KeepEdit.empty(1);
  }
  int userId;
  Map<String, dynamic> data = {
    "id" : -1,
    "color" : "FF42A5F5",
    "title" : "newKeep",
    "type" : 1,
    "data" : "",
    "date" : "${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, "0")}-${DateTime.now().day.toString().padLeft(2, "0")}"
  };

  var child = _KeepEdit.empty(1);

  @override
  State<StatefulWidget> createState() => child;
}

class _KeepEdit extends State<KeepEdit> {
  _KeepEdit(Map<String, dynamic> data, this.userId){
    this.data = data;
    this.userId = userId;
  }
  _KeepEdit.empty(this.userId);
  int userId;
  Map<String, dynamic> data = {
    "id" : -1,
    "color" : "FF42A5F5",
    "title" : "newKeep",
    "type" : 1,
    "data" : "",
    "date" : "${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, "0")}-${DateTime.now().day.toString().padLeft(2, "0")}"
  };
  late TextInput input;
  TextEditingController title = TextEditingController();
  late Color typeColor;


  @override
  void initState() {
    typeColor = Color(int.parse(data["color"] ?? "FF42A5F5", radix: 16));
    data["userId"] = userId;
    var aa = 0;
  }

  @override
  Widget build(BuildContext context) {

    input = TextInput(data["data"] ?? "");
    title.text = data["title"] ?? "newKeep";
    typeColor = this.typeColor;

    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: typeColor,
          title: Container(
            alignment: Alignment.centerLeft,
            child: TextField(
              controller: title,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
              cursorColor: Colors.greenAccent,
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          actions: [
            IconButton(onPressed: () {
              data["title"] = title.text;
              data["data"] = input.input.content.text;
              UserRequest.updateKeep(data);
            }, icon: const Icon(Icons.save)),
            PopupMenuButton(
              onSelected: (value) {
                data["type"] = int.parse((value as Map<String, dynamic>)["id"].toString());
                data["color"] = value["color"].toString();
                setState(() {
                  typeColor = Color(int.parse(value["color"].toString(), radix: 16));
                });
              },
              icon: const Icon(Icons.circle_outlined),
              itemBuilder: (BuildContext context) {
                return <Map<String, dynamic>>[
                  {"type" : "Regular", "value" : {"id" : 1, "color" : "FF42A5F5"}},
                  {"type" : "Important", "value" : {"id" : 2, "color" : "FFFF1744"}},
                ].map((Map<String, dynamic> e) =>
                    PopupMenuItem(child: Text(e["type"].toString()), value: e["value"])
                ).toList();
              },
            ),
          ],
        ),
        body: input,
      ),
      onWillPop: () async {
        var res = await UserRequest.getUserKeeps({"id" : data["userId"]});
        var jsonData = json.decode(res);
        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPage(jsonData["id"], jsonData["res"])));
        return false;
      },
    );
  }

  @override
  void didUpdateWidget(KeepEdit oldWidget) {
    super.didUpdateWidget(oldWidget);
  }
}