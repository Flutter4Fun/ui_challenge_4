
import 'dart:math';

import 'package:flutter/material.dart';

double randD(double min, double max) =>
    Random().nextDouble() * (max - min) + min;

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
  Color color;
  double currentSize;
  double speed;
  double targetSize;

  double _positionPercent = 0;

  double get positionPercent {
    return _positionPercent;
  }

  Electron({
    @required this.color,
    @required this.currentSize,
    @required this.speed,
    @required this.targetSize,
  });

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
    final size = randD(4, 6);
    final initialSize = size * 3;
    final color = colors[Random().nextInt(colors.length)];
    return Electron(
      color: color,
      currentSize: initialSize,
      targetSize: size,
      speed: randD(0.003, 0.01),
    );
  }
}
