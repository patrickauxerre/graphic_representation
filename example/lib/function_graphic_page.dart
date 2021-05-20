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
              "f(x) = exp(-x²/8)",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.purple),
              textScaleFactor: 1.6,
            )),
        Padding(
            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: Text(
              "g(x) = sin(x)/x",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
              textScaleFactor: 1.6,
            )),
        Padding(
            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: Text(
              "h(x) = sin(x/2)",
              style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
              textScaleFactor: 1.6,
            )),
        FunctionGraphic(
          size: Size(MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height * 0.5),
          functions: [(x) => exp(-x * x/8), (x) => sin(x) / x, (x) => sin(x/2)],
          functionsXt: [],
          functionsYt: [],
          colorAxes: Colors.black,
          colors: [Colors.purple, Colors.green, Colors.red],
          nbGradX: 11,
          minX: -10,
          maxX: 10,
          minY: -1,
          maxY: 1,
          strokeLine: 3.0,
        ),
      ],
    ));
  }
}
