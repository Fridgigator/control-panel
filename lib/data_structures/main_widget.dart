import 'package:flutter/cupertino.dart';

abstract class MainWidget extends StatelessWidget {
  const MainWidget({super.key});
  bool hasSideBar();
  Widget getSideBar();
}
