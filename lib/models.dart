
import 'dart:math';

import 'package:flutter/material.dart';

double randD(double min, double max) =>
    Random().nextDouble() * (max - min) + min;

class Orbit {
  final List<Electron> electrons;
  final double angle;

  Orbit({
    required this.electrons,
    required this.angle,
  });
}

extension OrbitsExtension on List<Orbit> {
  void updateElectronsPosition() {
    forEach((orbit) {
      for (var electron in orbit.electrons) {
        electron.move();
      }
    });
  }
}

class Electron {
  double speed;

  double currentSize;
  double targetSize;

  Color currentColor;
  Color targetColor;

  double _positionPercent = 0;

  double get positionPercent {
    return _positionPercent;
  }

  Electron({
    required this.currentSize,
    required this.targetSize,
    required this.currentColor,
    required this.targetColor,
    required this.speed,
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
    final size = randD(5, 7);
    final initialSize = size * 8;
    final color = colors[Random().nextInt(colors.length)];
    return Electron(
      currentSize: initialSize,
      targetSize: size,
      currentColor: color.withOpacity(0.1),
      targetColor: color,
      speed: randD(0.008, 0.012),
    );
  }
}
