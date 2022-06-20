import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          brightness: Brightness.light,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
        ),
        themeMode: ThemeMode.dark,
        debugShowCheckedModeBanner: false,
        home: const MyHomePage(title: 'Refrigigators '),
      );
    });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: Text(widget.title),
            leading: GestureDetector(
                onTap: () {
                  setState(() {
                    _counter++;
                  });
                },
                child: const Icon(
                  Icons.menu,
                )),
            actions: <Widget>[
              Padding(
                  padding: EdgeInsets.all(24.0),
                  child: GestureDetector(
                      onTap: () {},
                      child: const Icon(
                        Icons.login,
                        size: 26.0,
                      )))
            ]),
        body: Padding(
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
                child: Center(
                    child: Column(children: [
              FrontPageContent(
                title: "Monitors your fridge",
                text: "Text",
                imageSource: "assets/fridge.svg",
                textPos: 0,
              ),
              FrontPageContent(
                title: "The perfect place for your produce",
                text: "Text",
                imageSource: "assets/lemon.svg",
                textPos: 1,
              ),
              FrontPageContent(
                title: "Technology",
                text: "Text",
                imageSource: "assets/network.svg",
                textPos: 2,
              ),
              FrontPageContent(
                  title: "Open Source",
                  text: "",
                  imageSource: "assets/Opensource.svg",
                  textPos: 3)
            ])))));
  }
}

// ignore: must_be_immutable
class FrontPageContent extends StatelessWidget {
  final String title;
  final String text;
  final String imageSource;
  late bool textLeft;
  final List<ElevatedButton>? buttons;
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
              style: const TextStyle(fontSize: 48),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  Text(
                    text,
                    style: const TextStyle(fontSize: 24),
                  ),
                  Row(
                    children: buttons != null ? buttons! : List.empty(),
                  )
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
