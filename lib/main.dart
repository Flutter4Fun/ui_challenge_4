
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'AtomWidget.dart';
import 'models.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Orbit> _orbits = [
    Orbit(electrons: [], angle: 0.0),
    Orbit(electrons: [], angle: 60.0),
    Orbit(electrons: [], angle: 120.0),
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF191636),
      body: Center(
        child: AtomWidget(
          orbits: _orbits,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _orbits[math.Random().nextInt(_orbits.length)].electrons.add(Electron.random());
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
