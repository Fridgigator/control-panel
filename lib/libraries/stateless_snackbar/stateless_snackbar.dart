// Based on https://github.com/flutter/flutter/blob/b8f7f1f986/packages/flutter/lib/src/material/snack_bar.dart#L188
import 'dart:developer';

import 'package:flutter/material.dart';

const double _singleLineVerticalPadding = 14.0;

class StatelessSnackbar extends StatelessWidget {
  final Widget child;
  final bool visible;
  final Color? backgroundColor;
  const StatelessSnackbar(
      {super.key,
      required this.child,
      required this.backgroundColor,
      required this.visible});
  final double horizontalPadding = 16.0;
  @override
  Widget build(BuildContext context) {
    log("Building snackbar");
    final EdgeInsetsGeometry padding = EdgeInsetsDirectional.only(
        start: horizontalPadding, end: horizontalPadding);

    return Positioned(
        top: 0,
        child: AnimatedSize(
            curve: Curves.easeIn,
            duration: const Duration(milliseconds: 200),
            child: visible
                ? Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: _singleLineVerticalPadding),
                    width: MediaQuery.of(context).size.width,
                    color: backgroundColor,
                    child: Padding(padding: padding, child: child))
                : Container()));
  }
}
