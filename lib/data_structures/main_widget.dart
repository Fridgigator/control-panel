import 'package:flutter/material.dart';

abstract class MainWidget extends StatefulWidget {
  const MainWidget({super.key});
  bool hasSideBar();
  Widget getSideBar(BuildContext context);

  FloatingActionButton? getFAB(BuildContext context);
}
