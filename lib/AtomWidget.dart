import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'models.dart';

class AtomWidget extends StatefulWidget {
  final List<Orbit> orbits;

  const AtomWidget({Key? key, required this.orbits}) : super(key: key);

  @override
  _AtomWidgetState createState() => _AtomWidgetState();
}

class _AtomWidgetState extends State<AtomWidget> with SingleTickerProviderStateMixin {
  late Timer t;

  @override
  void initState() {
    super.initState();
    t = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      setState(() {
        widget.orbits.updateElectronsPosition();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final atomSize = (MediaQuery.of(context).size.shortestSide / 3) * 2;
    return Stack(
      children: [
        ...widget.orbits
            .map(
              (orbit) => Center(
                child: Transform.rotate(
                  angle: degreesToRads(orbit.angle),
                  child: CustomPaint(
                    painter: _OrbitPainter(orbit),
                    size: Size(atomSize, atomSize),
                  ),
                ),
              ),
            )
            .toList(),
        Center(
          child: Container(
            width: atomSize / 10,
            height: atomSize / 10,
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Color(0xffffc560),
                    Color(0xffff593b),
                  ],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                )),
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    t.cancel();
    super.dispose();
  }
}

class _OrbitPainter extends CustomPainter {
  final Orbit orbit;

  _OrbitPainter(this.orbit);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    Path orbitPath = Path();

    final width = size.shortestSide;
    final height = width * 0.24;

    orbitPath.addOval(Rect.fromCenter(center: center, width: width, height: height));

    canvas.drawPath(
      orbitPath,
      Paint()
        ..color = const Color(0xFF26224f)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1,
    );

    for (var electron in orbit.electrons) {
      electron.currentSize = lerpDouble(electron.currentSize, electron.targetSize, 0.08)!;
      electron.currentColor = Color.lerp(electron.currentColor, electron.targetColor, 0.08)!;
      final degree = math.pi * 2 * electron.positionPercent;
      canvas.drawCircle(
        center + Offset(math.cos(degree) * (width / 2), math.sin(degree) * (height / 2)),
        electron.currentSize / 2,
        Paint()
          ..color = electron.currentColor
          ..style = PaintingStyle.fill
          ..strokeCap = StrokeCap.round
          ..strokeWidth = electron.currentSize,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _OrbitPainter oldDelegate) => true;
}

double degreesToRads(double deg) {
  return (deg * math.pi) / 180.0;
}
