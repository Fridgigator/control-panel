import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<MyHomePage> {
  Map<int, List<String>> points = {};

  int angle = 0;
  Offset? position;
  Timer? t;
  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 360; i++) {
      points[i] = ["a", "v"];
    }

    t = Timer.periodic(const Duration(microseconds: 13889), (t) {
      setState(() {
        if (angle == 360 * 10 - 1) {
          angle = 0;
        } else {
          angle++;
        }
      });
    });
  }

  @override
  void deactivate() {
    t?.cancel();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 10,
      height: 10,
      child: Radar(angle: angle, points: points, radius: 50),
    );
  }
}

class Radar extends StatefulWidget {
  /// The angle (in degrees) of the sweep.
  final int angle;

  /// The radius of the radar

  final double radius;

  /// A map of points to display. The key is the angle (in degrees) of the point,
  /// and the value is a list of corresponding values.
  final Map<int, List<String>> points;

  const Radar(
      {super.key,
      required this.angle,
      required this.points,
      required this.radius});

  @override
  State<StatefulWidget> createState() => _RadarState();
}

class _RadarState extends State<Radar> {
  // mousePosition will be null when the mouse leaves the screen.
  Offset? mousePosition;
  void _updateLocation(PointerEvent details) {
    setState(() {
      mousePosition = details.position;
    });
  }

  void _incrementExit(PointerEvent details) {
    setState(() {
      mousePosition = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: _updateLocation,
      onExit: _incrementExit,
      child: CustomPaint(
        painter: ScreenPainter(
            radius: widget.radius,
            angle: widget.angle,
            mousePosition: mousePosition,
            points: widget.points),
      ),
    );
  }
}

class ScreenPainter extends CustomPainter {
  // This angle is in degrees
  final int angle;
  final Offset? mousePosition;
  final Map<int, List<String>> points;
  final double radius;

  double get _angleRadian {
    return degreeToRadian(angle.toDouble());
  }

  ScreenPainter(
      {required this.radius,
      required this.points,
      required this.angle,
      required this.mousePosition});
  @override
  void paint(Canvas canvas, Size size) {
    // Don't draw outside the canvas
    canvas.clipRect(Rect.fromLTWH(0, 0, size.width, size.height));
    Map<Offset, String> positionToLabel = {};
    const radarGreen = Color.fromARGB(255, 0x96, 0xf9, 0x7b);
    var canvasPaint = Paint()..color = (const Color.fromARGB(255, 32, 32, 32));
    // Draw the black backgroumd
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), canvasPaint);
    Offset center = Offset(size.width / 2, size.height / 2);

    // The size of the sweep
    double sweepSize = 0.8;
    // SweepGradient is broken when the sweep crosses 0. This draws the whole canvas
    // and rotates that.
    drawRotated(
        canvas: canvas,
        center: center,
        angle: _angleRadian - sweepSize,
        drawFunction: () {
          var paint = Paint()
            ..color = radarGreen
            ..strokeWidth = 1
            ..style = PaintingStyle.stroke;

          // Draw the inner circles

          canvas.drawCircle(center, 1, paint);
          canvas.drawCircle(center, radius / 4, paint);
          canvas.drawCircle(center, radius / 2, paint);
          canvas.drawCircle(center, 3 * radius / 4, paint);
          canvas.drawCircle(center, radius, paint);

          // Make the sweep a bit blurry ahead also
          final Gradient sweepGradiant =
              SweepGradient(startAngle: 0, endAngle: 1, colors: [
            radarGreen.withAlpha(0),
            radarGreen.withAlpha(255),
            radarGreen.withAlpha(255),
            radarGreen.withAlpha(0),
          ], stops: const [
            0,
            0.90,
            0.95,
            1
          ]);
          // The center looks ugly without it
          final Gradient circularGradiant = RadialGradient(
            radius: 0.025,
            colors: [
              radarGreen.withAlpha(255),
              radarGreen.withAlpha(0),
            ],
          );

          var arcPaint = Paint()
            ..shader = sweepGradiant
                .createShader(Rect.fromCircle(center: center, radius: radius))
            ..style = PaintingStyle.fill;

          canvas.drawArc(Rect.fromCircle(center: center, radius: radius), 0, 1,
              true, arcPaint);

          // Draw the central circle
          var circularPaint = Paint()
            ..shader = circularGradiant
                .createShader(Rect.fromCircle(center: center, radius: radius))
            ..style = PaintingStyle.fill;

          canvas.drawCircle(center, 8, circularPaint);
        });

    Offset? position = mousePosition;
    // Draw the points
    for (int key in points.keys) {
      // get the angular distance from the sweep to the point
      int distance = getAbsoluteDistance(key, angle);

      // From the angular distance, calculate the opacity
      double opacity = getOpacity(distance);

      // Also, get the label of the current point
      List<String> value = points[key]!;
      var paint = Paint()
        ..color = radarGreen.withOpacity(opacity)
        ..strokeWidth = 1
        ..style = PaintingStyle.fill;

      // get the absolute coordinates of the point
      double angleInDegree = key.toDouble();

      List<Point> centers = getPointPositions(
          labels: value,
          angleInDegrees: angleInDegree,
          size: size,
          radius: radius);

      // Draw the points and save their label
      for (Point f in centers) {
        canvas.drawCircle(f.offset, 2, paint);
        positionToLabel[f.offset] = f.label;
      }
    }

    // We don't draw the label if the mouse is out of range
    if (position != null) {
      // Get each point's key (its coordinates on screen)
      for (Offset offset in positionToLabel.keys) {
        // If the mouse is within the point
        if (position >= offset - const Offset(2, 2) &&
            position <= offset + const Offset(2, 2)) {
          // Draw the text
          TextStyle textStyle = GoogleFonts.ibmPlexMono().copyWith(
              color: radarGreen, fontSize: 14, fontWeight: FontWeight.bold);

          final textSpan = TextSpan(
            text: positionToLabel[offset]!,
            style: textStyle,
          );
          final textPainter = TextPainter(
            text: textSpan,
            textDirection: TextDirection.ltr,
          );
          textPainter.layout(
            minWidth: 0,
            maxWidth: size.width,
          );
          var textSize = textPainter.size;

          // Draw the surrounding box, padded by 2 on each side
          canvas.drawRect(
              Rect.fromLTWH(position.dx + 6, position.dy + 6,
                  textSize.width + 8, textSize.height + 8),
              canvasPaint);
          canvas.drawRect(
              Rect.fromLTWH(position.dx + 6, position.dy + 6,
                  textSize.width + 8, textSize.height + 8),
              canvasPaint
                ..style = PaintingStyle.stroke
                ..strokeWidth = 2
                ..color = radarGreen);
          textPainter.paint(canvas, Offset(position.dx + 10, position.dy + 10));
          // Once a box was drawn, we're done. Even if there are overlapping points,
          // drawing more than one at a time will make a mess.
          break;
        }
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    if (oldDelegate is ScreenPainter &&
        oldDelegate.angle == angle &&
        oldDelegate.points == points) {
      return false;
    } else {
      return true;
    }
  }

  void drawRotated({
    required Canvas canvas,
    required Offset center,
    required double angle,
    required VoidCallback drawFunction,
  }) {
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(angle);
    canvas.translate(-center.dx, -center.dy);
    drawFunction();
    canvas.restore();
  }
}

double degreeToRadian(double degree) => degree * pi / 180.0;

// Get the absolute distance between Angle1 and Angle2 in degrees.
// If the distance is negative, it rolls over.
int getAbsoluteDistance(int angle1, int angle2) {
  int distance = angle1 % 360 - angle2 % 360;
  if (distance < 0) {
    distance += 360;
  }
  return distance;
}

double getOpacity(int distance) =>
    ((distance.toDouble() / 360.0) + 0.0625 / 2) / (1.0 + 0.0625 / 2);

List<Point> getPointPositions(
    {required List<String> labels,
    required double angleInDegrees,
    required Size size,
    required double radius}) {
  List<Point> returnVal = [];
  int amntPoints = labels.length;
  for (int i = 0; i < amntPoints; i++) {
    double xDim = (i + 1) *
        (radius / (amntPoints + 1)) *
        cos(degreeToRadian(angleInDegrees));
    double yDim = (i + 1) *
        (radius / (amntPoints + 1)) *
        sin(degreeToRadian(angleInDegrees));
    Offset offset = Offset(xDim + size.width / 2.0, yDim + size.height / 2.0);
    returnVal.add(Point(offset: offset, label: labels[i]));
  }
  return returnVal;
}

String getLabel(Map<int, List<String>> points, Offset offset) {
  String returnVal = "";

  return returnVal;
}

class Point {
  final Offset offset;
  final String label;

  Point({required this.offset, required this.label});
}
