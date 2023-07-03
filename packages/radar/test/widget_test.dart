// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:math';
import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';

import 'package:radar/main.dart';

void main() {
  test('degreeToRadian', () {
    expect(degreeToRadian(90), closeTo(pi / 2, 0.01));
    expect(degreeToRadian(180), closeTo(pi, 0.01));
    expect(degreeToRadian(270), closeTo(3 * pi / 2, 0.01));
    expect(degreeToRadian(360), closeTo(2 * pi, 0.01));

    expect(degreeToRadian(-90), closeTo(-pi / 2, 0.01));
    expect(degreeToRadian(-180), closeTo(-pi, 0.01));
    expect(degreeToRadian(-270), closeTo(-3 * pi / 2, 0.01));
    expect(degreeToRadian(-360), closeTo(-2 * pi, 0.01));
  });
  test('Esnure getAbsoluteDistance is always 0 <= dist < 360', () {
    for (int i = -5000; i < 5000; i++) {
      for (int j = -5000; j < 5000; j++) {
        int dist = getAbsoluteDistance(i, j);
        expect(dist, inInclusiveRange(0, 359));
      }
    }
  });
  test('Ensure getOpacity is always between 0 and 1', () {
    for (int i = 0; i < 359; i++) {
      expect(getOpacity(i), inInclusiveRange(0, 1));
    }
  });

  group('getPointPositions', () {
    test('One ping which is 0 degrees', () {
      List<Point> pos = getPointPositions(
          labels: ["a"],
          angleInDegrees: 0,
          size: const Size(500, 500),
          radius: 100);
      expect(pos.length, 1);
      expect(pos[0].label, "a");
      const translation = Offset(250, 250);
      expect((pos[0].offset - translation).direction,
          closeTo(degreeToRadian(0), 0.01));
    });

    test('One ping and degree of 350', () {
      List<Point> pos = getPointPositions(
          labels: ["a"],
          angleInDegrees: 350,
          size: const Size(500, 500),
          radius: 100);
      const translation = Offset(250, 250);

      expect(pos.length, 1);
      expect(pos[0].label, "a");
      expect((pos[0].offset - translation).direction + 2 * pi,
          closeTo(degreeToRadian(350), 0.01));
    });

    test('One ping and degree of 350, ensuring length', () {
      List<Point> pos = getPointPositions(
          labels: ["a"],
          angleInDegrees: 350,
          size: const Size(500, 500),
          radius: 100);
      const translation = Offset(250, 250);
      const paddingDistance = Offset(25, 25);
      expect(pos.length, 1);
      expect(pos[0].label, "a");
      expect(
        ((pos[0].offset - translation - paddingDistance)).distance,
        closeTo(50, 0.01),
      );
    });
    test('Two pings and degree of 350, ensuring length', () {
      List<Point> pos = getPointPositions(
          labels: ["a", "b"],
          angleInDegrees: 350,
          size: const Size(500, 500),
          radius: 100);
      const translation = Offset(250, 250);
      const paddingDistance = Offset(25, 25);
      expect(pos.length, 2);
      expect(pos[0].label, "a");
      expect(
        (pos[0].offset - translation - paddingDistance).distance,
        closeTo(33.333, 0.01),
      );
      expect(
        (pos[1].offset - translation - paddingDistance).distance,
        closeTo(66.6666, 0.01),
      );
    });
    test('Three pings and degree of 350, ensuring length', () {
      List<Point> pos = getPointPositions(
          labels: ["a", "b", "c"],
          angleInDegrees: 350,
          size: const Size(500, 500),
          radius: 100);
      const translation = Offset(250, 250);
      const paddingDistance = Offset(25, 25);

      expect(pos.length, 3);
      expect(pos[0].label, "a");
      expect(
        (pos[0].offset - translation - paddingDistance).distance,
        closeTo(25, 0.01),
      );
      expect(
        (pos[1].offset - translation - paddingDistance).distance,
        closeTo(50, 0.01),
      );
      expect(
        (pos[2].offset - translation - paddingDistance).distance,
        closeTo(75, 0.01),
      );
    });

    test('Four pings and degree of 350, ensuring length', () {
      List<Point> pos = getPointPositions(
          labels: ["a", "b", "c", "d"],
          angleInDegrees: 350,
          size: const Size(500, 500),
          radius: 100);
      const translation = Offset(250, 250);
      const paddingDistance = Offset(25, 25);
      expect(pos.length, 4);
      expect(pos[0].label, "a");
      expect(
        (pos[0].offset - translation - paddingDistance).distance,
        closeTo(20, 0.01),
      );
      expect(
        (pos[1].offset - translation - paddingDistance).distance,
        closeTo(40, 0.01),
      );
      expect(
        (pos[2].offset - translation - paddingDistance).distance,
        closeTo(60, 0.01),
      );
      expect(
        (pos[3].offset - translation - paddingDistance).distance,
        closeTo(80, 0.01),
      );
    });
  });
}
