import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

import '../main.dart';

const users = {
  'dribbble@gmail.com': '12345',
  'hunter@gmail.com': 'hunter',
};

class LoginScaffold extends StatefulWidget {
  const LoginScaffold({super.key, required this.darkTheme});
  final bool darkTheme;
  @override
  createState() => _LoginState();
}

class _LoginState extends State<LoginScaffold> {
  final Duration loginTime = const Duration(seconds: 3);

  Future<String?> _authUser(LoginData data) {
    debugPrint('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(data.name)) {
        return 'User not exists';
      }
      if (users[data.name] != data.password) {
        return 'Password does not match';
      }
      return null;
    });
  }

  Future<String?> _signupUser(SignupData data) {
    debugPrint('Signup Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      return null;
    });
  }

  Future<String> _recoverPassword(String name) {
    debugPrint('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'User not exists';
      }
      return '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'Fridgigator',
      logo: const Svg('assets/assets/fridge.svg'),
      loginProviders: [
        LoginProvider(callback: () {
          return null;
        })
      ],
      onLogin: _authUser,
      onSignup: _signupUser,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const MyApp(),
        ));
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}
