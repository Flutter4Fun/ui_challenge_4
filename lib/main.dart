import 'package:f4f_bottom_bar/f4f_bottom_bar.dart';
import 'package:flutter/foundation.dart';
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
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Orbit> _orbits = [
    Orbit(electrons: [], angle: 0.0),
    Orbit(electrons: [], angle: 60.0),
    Orbit(electrons: [], angle: 120.0),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF191636),
      body: Center(
        child: AtomWidget(
          orbits: _orbits,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _orbits[math.Random().nextInt(_orbits.length)]
                .electrons
                .add(Electron.random());
          });
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const F4FBottomBarWidget(
        sections: [
          F4FBottomBarSection(title: 'Blog Post in Flutter 4 Fun', link: 'https://flutter4fun.com/ui-challenge-4/'),
          if (!kIsWeb)
            F4FBottomBarSection(title: 'Live Demo', link: 'https://flutter4fun.github.io/ui_challenge_4_live/#/'),
          F4FBottomBarSection(title: 'Source Code', link: 'https://github.com/Flutter4Fun/ui_challenge_4/'),
        ],
      ),
    );
  }
}
