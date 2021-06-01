import 'dart:math';
import 'package:flutter/material.dart';

class VortexDot {
  late final double _r;
  late final double _x;
  late final double _y;
  late Color _color;
  late double _dFadeOut;

  VortexDot(double r, double x, double y, Color color, double dFadeOut) {
    _r = r;
    _x = x;
    _y = y;
    _color = color;
    _dFadeOut = dFadeOut;
  }

  void tick() {
    _color = Color.fromRGBO(
      _color.red,
      _color.green,
      _color.blue,
      _color.opacity - _dFadeOut,
    );
  }

  double get r {
    return _r;
  }

  double get x {
    return _x;
  }

  double get y {
    return _y;
  }

  Color get color {
    return _color;
  }
}

class VortexLine {
  late final int _tailCount;
  late final int _lifespan;
  late final double _rotations;
  late final double _dotR;
  late final Color _color;
  late final double _startRadian;
  late int _waitStart;
  double _life = 1.0;
  final List<VortexDot> _dots = [];

  VortexLine(
    int tailCount,
    int lifespan,
    double rotations,
    double dotR,
    Color color,
    double startRadian,
    int waitStart,
  ) {
    _tailCount = tailCount;
    _lifespan = lifespan;
    _rotations = rotations;
    _dotR = dotR;
    _color = color;
    _startRadian = startRadian;
    _waitStart = waitStart;
  }

  void tick() {
    if (0 < _waitStart) {
      --_waitStart;
      return;
    }
    double radius = 0.5 - _dotR * 1.5 - (0.5 - _dotR * 3) * (1.0 - _life);
    double radian = (sqrt(_life) * pi * 2 * _rotations) + _startRadian;
    _dots.add(VortexDot(
      _dotR,
      0.5 + radius * sin(radian),
      0.5 + radius * cos(radian),
      _color,
      1.0 / (_tailCount + 2),
    ));

    if (_dots.length > _tailCount) {
      _dots.removeAt(0);
    }

    for (int j = 0; j < _dots.length; ++j) {
      _dots[j].tick();
    }

    _life -= 1 / _lifespan;
    if (_life < 0) {
      _life = 1.0;
    }
  }

  List<VortexDot> get dots {
    return _dots;
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
    int tailCount = 10,
    int lifespan = 100,
    double rotations = 3.0,
    double dotR = 0.04,
    int lineCount = 3,
  }) {
    for (int i = 0; i < lineCount; ++i) {
      _lines.add(VortexLine(
        tailCount,
        lifespan,
        rotations,
        dotR,
        _dotColors[i % _dotColors.length],
        pi * 2 / _dotColors.length * i,
        i * (lifespan / lineCount).round(),
      ));
    }
  }

  List<VortexLine> tick() {
    for (int i = 0; i < _lines.length; ++i) {
      _lines[i].tick();
    }

    return _lines;
  }
}
