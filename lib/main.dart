import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RotateText(),
    );
  }
}

class RotateText extends StatefulWidget {
  RotateText({Key key}) : super(key: key); // changed

  @override
  _RotateTextState createState() => _RotateTextState();
}

class _RotateTextState extends State<RotateText> {
  double finalAngle = 0.0;

  @override
  Widget build(BuildContext context) {
    return _defaultApp(context);
  }

  _defaultApp(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Single finger Rotate image'), // changed
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 0.65,
              height: MediaQuery.of(context).size.width * 0.65,
              child: Image.asset('assets/grid.png'),
            ),
            SizedBox(height: 30),
            Container(
              width: MediaQuery.of(context).size.width * 0.65,
              height: MediaQuery.of(context).size.width * 0.65,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onPanUpdate: (details) {
                      Offset centerOfGestureDetector = Offset(
                          constraints.maxWidth / 2, constraints.maxHeight / 2);
                      final touchPositionFromCenter =
                          details.localPosition - centerOfGestureDetector;
                      print(touchPositionFromCenter.direction * 180/pi);
                      setState(
                            () {
                          finalAngle = touchPositionFromCenter.direction;
                        },
                      );
                    },
                    child: Transform.rotate(
                      angle: finalAngle,
                      child: Image.asset(
                        'assets/wheel.png',
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}