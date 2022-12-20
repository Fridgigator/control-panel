import 'package:flutter/material.dart';

abstract class MainWidget extends StatelessWidget {
  const MainWidget({super.key});
  bool hasSideBar();
  Widget getSideBar(BuildContext context);
}
