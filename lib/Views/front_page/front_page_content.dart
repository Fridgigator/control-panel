// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'front_page_button.dart';

// ignore: must_be_immutable
class FrontPageContent extends StatelessWidget {
  final String title;
  final String text;
  final String imageSource;
  late bool textLeft;
  final List<FrontPageButton>? buttons;
  FrontPageContent(
      {key,
      required this.title,
      required this.text,
      required this.imageSource,
      this.buttons,
      required textPos})
      : super(key: key) {
    textLeft = textPos % 2 == 0;
  }
  @override
  Widget build(BuildContext context) {
    Padding textWidget = Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.w300),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  SizedBox(
                      width: double.infinity,
                      child: Text(
                        text,
                        style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w100,
                            height: 1.4),
                      )),
                  SizedBox(
                      width: double.infinity,
                      child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                          child: Wrap(
                            alignment: WrapAlignment.spaceAround,
                            children: buttons != null ? buttons! : List.empty(),
                          )))
                ]))
          ],
        ));
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 128, 0, 128),
        child: Row(
          children: textLeft
              ? [
                  Expanded(
                      flex: 1,
                      child: Container(
                          constraints: const BoxConstraints(
                              minWidth: 300, maxWidth: 576),
                          child: textWidget)),
                  Expanded(
                    flex: 1,
                    child: Container(
                        constraints:
                            const BoxConstraints(minWidth: 300, maxWidth: 576),
                        child: SvgPicture.asset(imageSource)),
                  ),
                ]
              : [
                  Expanded(
                    flex: 1,
                    child: Container(
                        constraints:
                            const BoxConstraints(minWidth: 300, maxWidth: 576),
                        child: SvgPicture.asset(imageSource)),
                  ),
                  Expanded(
                      flex: 1,
                      child: Container(
                          constraints: const BoxConstraints(
                              minWidth: 300, maxWidth: 576),
                          child: textWidget)),
                ],
        ));
  }
}
