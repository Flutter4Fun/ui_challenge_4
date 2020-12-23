import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'models.dart';

class AtomWidget extends StatefulWidget {
  final List<Orbit> orbits;

  const AtomWidget({Key key, @required this.orbits}) : super(key: key);

  @override
  _AtomWidgetState createState() => _AtomWidgetState();
}

class _AtomWidgetState extends State<AtomWidget> with SingleTickerProviderStateMixin {
  Timer t;
  @override
  void initState() {
    super.initState();
    t = Timer.periodic(Duration(milliseconds: 16), (timer) {
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
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Color(0xffffc560),
                    Color(0xffff593b),
                  ],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                )
            ),
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
    Path orbitPath = new Path();

    final width = size.shortestSide;
    final height = width * 0.24;
    orbitPath.addOval(Rect.fromCenter(center: center, width: width, height: height));

    canvas.drawPath(
      orbitPath,
      Paint()
        ..color = Color(0xFF26224f)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1,
    );

    orbit.electrons.forEach((electron) {
      final metrics = orbitPath.computeMetrics(forceClosed: true);
      final metric = metrics.first;
      final start = electron.positionPercent * metric.length + (electron.currentSize / 2);
      final end = start + electron.currentSize - (electron.currentSize / 2);
      final electronPath = metric.extractPath(start, end);

      electron.currentSize = lerpDouble(electron.currentSize, electron.targetSize, 0.08);
      canvas.drawPath(
          electronPath,
          Paint()
            ..color = electron.color
            ..style = PaintingStyle.stroke
            ..strokeCap = StrokeCap.round
            ..strokeWidth = electron.currentSize);
    });
  }

  @override
  bool shouldRepaint(covariant _OrbitPainter oldDelegate) => true;
}

num degreesToRads(num deg) {
  return (deg * math.pi) / 180.0;
}
