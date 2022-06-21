import 'package:flutter/material.dart';

class FrontPageButton extends StatelessWidget {
  final String text;
  final VoidCallback onClick;
  const FrontPageButton({key, required this.text, required this.onClick})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(onPressed: onClick, child: Text(text));
  }
}
