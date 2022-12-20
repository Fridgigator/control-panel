import 'package:control_panel/libraries/stateless_snackbar/stateless_snackbar.dart';
import 'package:control_panel/libraries/stateless_snackbar/viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatelessSnackbarController extends StatelessWidget {
  final Widget child;
  const StatelessSnackbarController({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => StatelessSnackbarViewModel()),
        ],
        builder: (context, child) {
          return Stack(fit: StackFit.expand, children: [
            this.child,
            StatelessSnackbar(
                backgroundColor: Colors.red,
                visible:
                    Provider.of<StatelessSnackbarViewModel>(context).visible,
                child: Text(
                    Provider.of<StatelessSnackbarViewModel>(context).text ??
                        ""))
          ]);
        });
  }
}
