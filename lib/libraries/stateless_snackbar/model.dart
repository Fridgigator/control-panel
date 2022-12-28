import 'package:control_panel/libraries/stateless_snackbar/viewmodel.dart';

class StatelessSnackbarModel {
  static final StatelessSnackbarModel _instance =
      StatelessSnackbarModel._internal();
  final _snackbarVM = StatelessSnackbarViewModel();
  factory StatelessSnackbarModel() {
    return _instance;
  }

  StatelessSnackbarModel._internal();
  void setText(String text) {
    _snackbarVM.text = text;
  }

  void removeText() {
    _snackbarVM.text = null;
  }
}
