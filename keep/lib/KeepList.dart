import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:keep/APIRequest.dart';
import 'package:keep/KeepEdit.dart';

class KeepList extends StatefulWidget {
  KeepList(this.data, {super.key});
  List<dynamic> data;
  @override
  State<StatefulWidget> createState() => _KeepList(data);
}

class _KeepList extends State<KeepList>{
  _KeepList(this.data);
  List<dynamic> data;



  @override
  Widget build(BuildContext context) {
    List<Widget> views = <Widget>[];
    for(int i = 0; i < data.length; i++){
      views.add(KeepContent(data[i], refresh));
    }
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return views[index];
      },
      itemCount: data.length,
    );
  }

  void refresh() async {
    var res = await UserRequest.getUserKeeps({"id" : data[0]["userId"]});
    setState(() {
      data = json.decode(res)["res"];
    });
  }
}
// ignore: must_be_immutable
class KeepContent extends StatefulWidget {
  Map<String, dynamic> data;
  Function refresh;
  KeepContent(this.data, this.refresh, {super.key});
  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() => _KeepContent(data);
}

class _KeepContent extends State<KeepContent> {
  _KeepContent(this.data);
  Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) =>
          KeepEdit(data, data["userId"])
        ));
      },
      child: Card(
        margin: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 2,
        child: ClipPath(
          clipper: ShapeBorderClipper(shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0)
          )),
          child: Container(
            // height: 100,
            decoration: BoxDecoration(
              border: Border(
                  left: BorderSide(color: Color(int.parse(data["color"].toString(), radix: 16)), width: 7),
                  right: BorderSide(color: Color.fromARGB(40, 0, 0, 0), width: 1),
                  top: BorderSide(color: Color.fromARGB(40, 0, 0, 0), width: 1),
                  bottom: BorderSide(color: Color.fromARGB(40, 0, 0, 0), width: 1)
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Stack(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        child:  Align(alignment: Alignment.centerLeft, child: Text(data["title"].toString(), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        child:  Align(alignment: Alignment.centerLeft, child: Text(data["date"].toString(), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
                      )
                    ],
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: PopupMenuButton(
                      onSelected: (value) {
                        if (value == "Delete"){
                          setState(() {
                            UserRequest.deleteKeep({"id" : data["id"]});
                            widget.refresh();
                          });
                        }
                      },
                      itemBuilder: (BuildContext context){
                        return ["Delete"].map((e) =>
                            PopupMenuItem(child: Text(e), value: e,)
                        ).toList();
                      },
                    )
                  )
                ],
              )
            ),
          ),
        )
      ),
    );
  }
}