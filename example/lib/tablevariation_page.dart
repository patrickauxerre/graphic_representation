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
                padding: EdgeInsets.only(top: 50.0, bottom: 20.0),
                child: Text(
                  "TABLE VARIATION",
                  style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                  textScaleFactor: 1.5,
                )),
            TableVariation(
              size: Size(MediaQuery.of(context).size.width,
                  MediaQuery.of(context).size.height * 0.4),
              rowsLabels: [
                ["x", "-∞", "-1", "0", "1", "+∞"],
                ["f '(x)", "-/0", "+/NAN", "+/0","0"],
                ["f(x)", "+∞/DES", "-1/INC", "+∞/NAN/-∞/INC","5/CONST","5"]
              ],
              fontSize: 18.0,
            )
          ],
        ));
  }
}
