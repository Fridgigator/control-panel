import 'package:control_panel/libraries/stateless_snackbar/stateless_snackbar.dart';
import 'package:flutter/material.dart';

class StatelessSnackbarController extends StatelessWidget {
  final Widget child;
  const StatelessSnackbarController({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(fit: StackFit.expand, children: [
      child,
      const StatelessSnackbar(backgroundColor: Colors.red)
    ]);
  }
}
