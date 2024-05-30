import 'dart:convert';
import 'package:http/http.dart';

class UserRequest {
  static final client = Client();
  static const url = "http://10.0.2.2:2301";

  static Future<String> login(data) async {
    try {
      final res = await client.post(
        Uri.parse("$url/login"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(data)
      );
      return res.body;
    }
    catch (e){
      return e.toString();
    }
  }
  static Future<String> getUserKeeps(data) async {
    try {
      final res = await client.post(
          Uri.parse("$url/getUserKeeps"),
          headers: {
            'Content-Type': 'application/json',
          },
          body: json.encode(data)
      );
      return res.body;
    }
    catch (e){
      return e.toString();
    }
  }
  static void updateKeep(data) async {
    try {
      await client.post(
          Uri.parse("$url/updateKeep"),
          headers: {
            'Content-Type': 'application/json',
          },
          body: json.encode(data)
      );
    }
    catch (e){
      return;
    }
  }

  static void deleteKeep(data) async {
    try {
      await client.post(
          Uri.parse("$url/deleteKeep"),
          headers: {
            'Content-Type': 'application/json',
          },
          body: json.encode(data)
      );
    }
    catch (e){
      return;
    }
  }
}