import 'package:control_panel/Views/front_page/desktop/front_page_desktop.dart';
import 'package:flutter/material.dart';
import 'phone/front_page_phone.dart';

class FrontPage extends StatelessWidget {
  const FrontPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(isLargeScreen(context));
    if (isLargeScreen(context)) {
      return const FrontPageDesktop();
    } else {
      return const FrontPagePhone();
    }
  }

  static bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > 1200;
  } //Small screen is any screen whose width is less than 800 pixels

  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < 800;
  } //Medium screen is any screen whose width is less than 1200 pixels,

  //and more than 800 pixels
  static bool isMediumScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > 800 &&
        MediaQuery.of(context).size.width < 1200;
  }
}
