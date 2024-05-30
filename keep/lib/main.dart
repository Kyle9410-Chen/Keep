import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keep/KeepEdit.dart';
import 'package:keep/KeepList.dart';
import 'package:keep/Login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => _MyApp();
}

class _MyApp extends State<MyApp>{


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LoginPage()
    );
  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]);
    super.initState();
  }
}

class MainPage extends StatelessWidget {
  MainPage(this.id, this.data, {super.key});
  int id;
  List<dynamic> data;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar:  AppBar(
          bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.note_add_outlined)),
                Tab(icon: Icon(Icons.schedule))
              ],
          ),
          actions: [
            TextButton(onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));
            }, child: const Text("Logout", style: TextStyle(color: Colors.white, fontSize: 18))),
            TextButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => KeepEdit.empty(id)));
            }, child: const Text("New Keep", style: TextStyle(color: Colors.white, fontSize: 18)))
          ],
        ),
        body: TabBarView(
          children: [
            KeepList(data),
            Column(children: const [Text("two Page")])
          ],
        ),
      ),
    );
  }
}