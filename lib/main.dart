import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'vortex.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vortex 2',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: MyHomePage(title: 'Vortex 2'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Vortex _vortex = Vortex(
    size: 0.02,
    lineCount: 15,
  );

  @override
  void initState() {
    super.initState();
    new Timer.periodic(
      const Duration(milliseconds: 50),
      (Timer t) => setState(() {}),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size mediaSize = MediaQuery.of(context).size;
    final double size = min(mediaSize.width, mediaSize.height) - 8.0;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: size,
              height: size,
              child: ColoredBox(
                color: Colors.black,
                child: CustomPaint(
                  painter: MyPainter(_vortex.tick()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  late final List<VortexLine> _lines;

  MyPainter(List<VortexLine> lines) {
    _lines = lines;
  }
  @override
  void paint(Canvas canvas, Size size) {
    final double sz = min(size.width, size.height);
    _lines.forEach((line) {
      line.dots.forEach((dot) {
        canvas.drawCircle(
          Offset(
            sz * (0.5 + dot.radius * sin(dot.angle)),
            sz * (0.5 + dot.radius * cos(dot.angle)),
          ),
          sz * dot.size,
          Paint()..color = dot.color,
        );
      });
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
