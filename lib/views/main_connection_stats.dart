import 'package:flutter/material.dart';

import 'package:im_animations/im_animations.dart';

class MainConnectionStat extends StatelessWidget {
  final bool darkTheme;
  const MainConnectionStat({super.key, required this.darkTheme});
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
                child: Column(
                  children: [
                    const Text("Connection status"),
                    Container(
                      height: 36,
                      margin: EdgeInsets.fromLTRB(18.0, 36, 18, 18),
                      child: ColorSonar(
                        contentAreaColor:
                            darkTheme ? Colors.black12 : Colors.white,
                        duration: Duration(seconds: 5),
                        contentAreaRadius: 18.0,
                        waveFall: 8,
                        child: CircleAvatar(
                          backgroundColor: darkTheme
                              ? Colors.green
                              : Colors.lightGreenAccent,
                          radius: 100,
                        ),
                      ),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [Text("5 up"), Text("6 down")])
                  ],
                ))));
  }
}
