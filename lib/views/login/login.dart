import 'dart:developer';

import 'package:control_panel/view_model/login/email.dart';
import 'package:control_panel/view_model/login/github.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';

class LoginScaffold extends StatelessWidget {
  const LoginScaffold({super.key, required this.darkTheme});
  final bool darkTheme;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => EmailViewModel()),
          ChangeNotifierProvider(create: (_) => GithubLoginViewModel())
        ],
        builder: (context, child) {
          return FlutterLogin(
            title: 'Fridgigator',
            logo: const Svg('assets/assets/fridge.svg'),
            loginProviders: [
              LoginProvider(
                icon: FontAwesomeIcons.github,
                callback:
                    Provider.of<GithubLoginViewModel>(context, listen: false)
                        .tryLogin,
              ),
            ],
            passwordValidator: (String? passwd) {
              if (passwd == null || passwd.length < 6) {
                return "Password should be at least 6 characters";
              } else {
                return null;
              }
            },
            onLogin:
                Provider.of<EmailViewModel>(context, listen: false).authUser,
            onSignup:
                Provider.of<EmailViewModel>(context, listen: false).signupUser,
            onSubmitAnimationCompleted: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const MyApp(),
              ));
            },
            onRecoverPassword:
                Provider.of<EmailViewModel>(context, listen: false)
                    .recoverPassword,
          );
        });
  }
}
