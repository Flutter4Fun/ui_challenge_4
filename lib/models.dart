
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:funny_counter/common.dart';

class Orbit {
  final List<Electron> electrons;
  final angle;

  Orbit({
    @required this.electrons,
    @required this.angle,
  });
}

extension OrbitsExtension on List<Orbit> {
  void updateElectronsPosition() {
    this.forEach((orbit) {
      orbit.electrons.forEach((electron) {
        electron.move();
      });
    });
  }
}

class Electron {
  final Color color;
  final double size;
  final double speed;

  double _positionPercent = 0;

  double get positionPercent {
    return _positionPercent;
  }

  Electron({
    Color color,
    double size,
    double speed,
  })  : color = color ?? Colors.red,
        size = size ?? 3,
        speed = speed ?? 0.005;

  void move() {
    if (_positionPercent >= 1.0) {
      _positionPercent = 0;
    }
    _positionPercent += speed;
  }

  static Electron random() {
    const colors = [
      Colors.greenAccent, Colors.redAccent, Colors.cyanAccent, Colors.purpleAccent,
      Colors.yellowAccent,
    ];
    return Electron(
      color: colors[Random().nextInt(colors.length)],
      size: 4,
      speed: randD(0.003, 0.01)
    );
  }
}
// (Random().nextDouble() * 0.003) + 0.005