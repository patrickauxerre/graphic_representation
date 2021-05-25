import 'package:flutter/material.dart';
import 'package:graphic_representation/graphic_representation.dart';

class TableVariationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.only(top: 50.0),
            child: Text(
              "TABLE VARIATION",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              textScaleFactor: 1.5,
            )),
        Padding(
            padding: EdgeInsets.only(top: 10.0, bottom: 20.0),
            child: Text(
              "f(x) = (x² - 3x + 6)/(x - 1)",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              textScaleFactor: 1.5,
            )),
        TableVariation(
          size: Size(MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height * 0.3),
          rowsLabels: [
            ["x", "-∞", "-1", "1", "3", "+∞"],
            ["f '(x)", "+/0", "-/NAN", "-/0", "+"],
            ["f(x)", "-∞/P0", "-5/P2", "-∞/P0/+∞/P2/NAN", "3/P0", "+∞/P2"]
          ],
          fontSize: 18.0,
          strokeWidth: 1.5,
        ),
        Padding(padding: EdgeInsets.only(top: 20.0)),
        FunctionGraphic(
          size: Size(MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height * 0.4),
          functions: [
            (x) => (x * x - 3 * x + 6) / (x - 1),
          ],
          functionsXt: [],
          functionsYt: [],
          colorAxes: Colors.black,
          colors: [Colors.purple, Colors.green, Colors.red],
          nbGradX: 12,
          minX: -11,
          maxX: 11,
          minY: -20,
          maxY: 20,
          strokeLine: 3.0,
        ),
      ],
    ));
  }
}
