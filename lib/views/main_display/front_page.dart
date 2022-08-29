import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class FrontPage extends StatefulWidget {
  const FrontPage({required this.githubToken, Key? key}) : super(key: key);
  final String githubToken;

  @override
  State<FrontPage> createState() => _MyFrontPageState();
}

class _MyFrontPageState extends State<FrontPage> {
  String? remoteName;

  Future<String> loadText() async {
    String authStr = "Bearer ${widget.githubToken}";
    Response r = await get(Uri.parse('https://api.github.com/user'),
        headers: <String, String>{
          'Authorization': authStr,
          'Accept': 'application/vnd.github+json',
        });
    Map<String, dynamic> user = jsonDecode(r.body);
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
