// Based on https://github.com/flutter/flutter/blob/b8f7f1f986/packages/flutter/lib/src/material/snack_bar.dart#L188

import 'package:control_panel/libraries/stateless_snackbar/viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const double _singleLineVerticalPadding = 14.0;

class StatelessSnackbar extends StatelessWidget {
  final Color? backgroundColor;
  const StatelessSnackbar({
    super.key,
    required this.backgroundColor,
  });
  final double horizontalPadding = 16.0;
  @override
  Widget build(BuildContext context) {
    final EdgeInsetsGeometry padding = EdgeInsetsDirectional.only(
        start: horizontalPadding, end: horizontalPadding);

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => StatelessSnackbarViewModel())
        ],
        builder: (context, child) {
          return Positioned(
              top: 0,
              child: AnimatedSize(
                  curve: Curves.easeIn,
                  duration: const Duration(milliseconds: 200),
                  child:
                      Provider.of<StatelessSnackbarViewModel>(context).visible
                          ? Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: _singleLineVerticalPadding),
                              width: MediaQuery.of(context).size.width,
                              color: backgroundColor,
                              child: Padding(
                                  padding: padding,
                                  child: Text(
                                      Provider.of<StatelessSnackbarViewModel>(
                                                  context)
                                              .text ??
                                          "")))
                          : Container()));
        });
  }
}
