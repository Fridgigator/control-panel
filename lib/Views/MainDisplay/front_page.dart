import 'package:flutter/cupertino.dart';

class FrontPage extends StatefulWidget {
  FrontPage({this.accessToken, Key? key}) : super(key: key);
  String? accessToken;

  @override
  State<FrontPage> createState() => _MyFrontPageState();
}

class _MyFrontPageState extends State<FrontPage> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.accessToken ?? "");
  }
}
