import 'dart:math';
import 'package:flutter/material.dart';
import 'package:graphic_representation/graphic_representation.dart';

class ParametrizedGraphicPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.only(top: 50.0, bottom: 10.0),
            child: Text(
              "x(t) = sin(2t) ; y(t) = sin(3t)",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.purple),
              textScaleFactor: 1.3,
            )),
        FunctionGraphic(
          size: Size(MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height * 0.35),
          functions: [],
          functionsXt: [(t) => sin(2 * t)],
          functionsYt: [(t) => sin(3 * t)],
          colorAxes: Colors.black,
          colorsParam: [Colors.purple],
          nbGradX: 11,
          minT: -pi,
          maxT: pi,
          minX: -1,
          maxX: 1,
          minY: -1,
          maxY: 1,
          strokeLine: 3.0,
        ),
        Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Text(
              "x(t) = tcos(t) ; y(t) = tsin(t)",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
              textScaleFactor: 1.1,
            )),
        Padding(
            padding: EdgeInsets.only(top: 5.0),
            child: Text(
              "x(t) = 10*cos(2*t)*cos(t) ; y(t) = 10*cos(2*t)*sin(t)",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
              textScaleFactor: 1.1,
            )),
        Padding(
            padding: EdgeInsets.only(top: 5.0),
            child: Text(
              "f(x) = x",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
              textScaleFactor: 1.1,
            )),
        Padding(
            padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
            child: Text(
              "f(x) = -x",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.purple),
              textScaleFactor: 1.1,
            )),
        FunctionGraphic(
          size: Size(MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height * 0.35),
          functions: [(x) => x, (x) => -x],
          functionsXt: [(t) => t * cos(t), (t) => 10 * cos(2 * t) * cos(t)],
          functionsYt: [(t) => t * sin(t), (t) => 10 * cos(2 * t) * sin(t)],
          colorAxes: Colors.black,
          colors: [Colors.blue, Colors.purple],
          colorsParam: [Colors.red, Colors.green],
          nbGradX: 11,
          minT: 0,
          maxT: 4 * pi,
          minX: -4 * pi,
          maxX: 4 * pi,
          minY: -4 * pi,
          maxY: 4 * pi,
          strokeLine: 3.0,
        ),
      ],
    ));
  }
}
