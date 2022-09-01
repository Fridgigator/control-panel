import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FrontPage extends StatefulWidget {
  const FrontPage({required this.accessCode, Key? key}) : super(key: key);
  final String accessCode;

  @override
  State<FrontPage> createState() => _MyFrontPageState();
}

class _MyFrontPageState extends State<FrontPage> {
  String? remoteName;

  Future<String> loadText() async {
    String authStr = widget.accessCode == "null" ? "" : widget.accessCode;
    http.Response r = await http.post(
        Uri.parse('https://fridgigator.herokuapp.com/api/get-user-info'),
        headers: <String, String>{'Authorization': authStr});
    Map<String, dynamic> user = jsonDecode(r.body);
    debugPrint("user=$user");
    return user["login"];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: loadText(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LinearProgressIndicator();
          } else {
            if (snapshot.data == null) {
              return const Text("Please log in");
            } else {
              return Text("Welcome ${snapshot.data}");
            }
          }
        });
  }
}
