import 'dart:math';
import 'package:flutter/material.dart';
import 'package:graphic_representation/graphic_representation.dart';

class FunctionGraphicPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.only(top: 50.0, bottom: 10.0),
            child: Text(
              "f(x) = exp(-x²)",
              style: TextStyle(fontWeight: FontWeight.bold),
              textScaleFactor: 1.6,
            )),
        FunctionGraphic(
          size: Size(MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height * 0.35),
          f: (x) => exp(-x * x),
          colorAxes: Colors.black,
          colorLine: Colors.purple,
          nbGradX: 11,
          minX: -3,
          maxX: 3,
          minY: 0,
          maxY: 1,
          strokeLine: 3.0,
        ),
        Padding(
            padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
            child: Text(
              "f(x) = sin(x)/x",
              style: TextStyle(fontWeight: FontWeight.bold),
              textScaleFactor: 1.6,
            )),
        FunctionGraphic(
          size: Size(MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height * 0.35),
          f: (x) => sin(x) / x,
          colorAxes: Colors.black,
          colorLine: Colors.purple,
          nbGradX: 11,
          minX: -20,
          maxX: 20,
          minY: -0.3,
          maxY: 1,
          strokeLine: 3.0,
        ),
      ],
    ));
  }
}
