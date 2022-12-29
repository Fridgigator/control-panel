
import 'package:flutter/material.dart';

import 'package:im_animations/im_animations.dart';

class MainConnectionStat extends StatelessWidget {
  final bool darkTheme;
  final bool hasPinged;
  final int amountUp;
  final int amountDown;
  const MainConnectionStat(
      {super.key,
      required this.darkTheme,
      required this.hasPinged,
      required this.amountDown,
      required this.amountUp});
  final Color leftBarColor = const Color(0xffff5182);
  final Color rightBarColor = const Color(0xff53fdd7);
  final double width = 7;
  @override
  Widget build(BuildContext context) {
    return Card(
        child: InkWell(
            onTap: () {},
            child: Container(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    const Text("Connection status"),
                    Container(
                      height: 36,
                      margin: const EdgeInsets.fromLTRB(18.0, 36, 18, 18),
                      child: ColorSonar(
                        wavesDisabled: !hasPinged,
                        contentAreaColor:
                            darkTheme ? Colors.black12 : Colors.white,
                        duration: const Duration(seconds: 5),
                        contentAreaRadius: 18.0,
                        waveFall: 8,
                        child: CircleAvatar(
                          backgroundColor:
                              (hasPinged ? Colors.green : Colors.red),
                          radius: 100,
                        ),
                      ),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("$amountUp up"),
                          Text("$amountDown down")
                        ])
                  ],
                ))));
  }
}
