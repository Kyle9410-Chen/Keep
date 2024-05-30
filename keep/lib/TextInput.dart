import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class TextInput extends StatefulWidget{
  TextInput(this.data);
  String data;
  late _TextInput input = _TextInput(data);
  @override
  State<StatefulWidget> createState() {
    return input;
  }
}

class _TextInput extends State<TextInput> {
  _TextInput(this.data);
  String data;
  late TextEditingController content = TextEditingController(text: data);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextField(
        keyboardType: TextInputType.multiline,
        maxLines: null,
        controller: content,
        decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: "Input anything you want to keep"
        ),
      ),
    );
  }

  @override
  void didUpdateWidget(TextInput oldWidget) {
    super.didUpdateWidget(oldWidget);
  }
}