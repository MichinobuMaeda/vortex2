import 'dart:math';
import 'package:flutter/material.dart';

class VortexDot {
  late final double size;
  late final Color color;
  late double radius;
  late double angle;

  VortexDot({
    required this.size,
    required this.radius,
    required this.angle,
    required this.color,
  });
}

class VortexLine {
  final List<VortexDot> dots = [];
  final double size;
  final Color color;
  final int dotCount;
  final int lifeCount;
  late int _waitCount;
  final double rotations;
  final double startAngle;
  late final double _radiusStart;
  late final double _radiusEnd;
  late double _life = 0.0;

  VortexLine({
    required this.size,
    required this.color,
    required this.dotCount,
    required this.lifeCount,
    required int waitCount,
    required this.rotations,
    required this.startAngle,
  }) {
    _waitCount = waitCount;
    _radiusStart = 0.5 - size * 1.5;
    _radiusEnd = size * 0.5;
  }

  double _deltaRadius() =>
      -(_radiusStart - _radiusEnd) / lifeCount * sqrt(_life) * sqrt2;
  double _deltaAngle() => rotations / lifeCount * 5 * sqrt(_life / 2 + 0.5);

  void tick() {
    if (0 < _waitCount) {
      --_waitCount;
      return;
    }

    if (dots.length < dotCount) {
      dots.add(VortexDot(
        size: size,
        radius:
            dots.length == 0 ? _radiusStart : dots.last.radius + _deltaRadius(),
        angle: dots.length == 0 ? startAngle : dots.last.angle + _deltaAngle(),
        color: Color.fromRGBO(
          color.red,
          color.green,
          color.blue,
          sqrt(1.0 / dotCount * (dots.length + 1)),
        ),
      ));
    } else {
      for (int i = 1; i < dots.length; ++i) {
        dots[i - 1].radius = dots[i].radius;
        dots[i - 1].angle = dots[i].angle;
      }
      dots.last.radius += _deltaRadius();
      dots.last.angle += _deltaAngle();
    }

    _life += 1.0 / lifeCount;
    if (1.0 < _life) {
      _life = 0.0;
      dots.last.radius = _radiusStart;
      dots.last.angle = startAngle;
    }
  }
}

class Vortex {
  final List<Color> _dotColors = [
    Color.fromRGBO(255, 0, 255, 0),
    Color.fromRGBO(0, 255, 255, 0),
    Color.fromRGBO(255, 255, 0, 0),
  ];
  final List<VortexLine> _lines = [];

  Vortex({
    int dotCount = 10,
    int lifeCount = 100,
    double rotations = 3.0,
    double size = 0.04,
    int lineCount = 3,
  }) {
    for (int i = 0; i < lineCount; ++i) {
      _lines.add(VortexLine(
        size: size,
        color: _dotColors[i % _dotColors.length],
        dotCount: dotCount,
        lifeCount: lifeCount,
        waitCount: (lifeCount / lineCount * i).round(),
        rotations: rotations,
        startAngle: pi * 2 / _dotColors.length * i,
      ));
    }
  }

  List<VortexLine> tick() {
    for (VortexLine line in _lines) {
      line.tick();
    }

    return _lines;
  }
}
