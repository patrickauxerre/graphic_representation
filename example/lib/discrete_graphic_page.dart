import 'package:flutter/material.dart';
import 'package:graphic_representation/graphic_representation.dart';

class DiscreteGraphicPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.only(top: 50.0, bottom: 10.0),
            child: Text(
              "TEMPÉRATURE (°C)",
              style: TextStyle(fontWeight: FontWeight.bold),
              textScaleFactor: 1.6,
            )),
        DiscreteGraphic(
          size: Size(MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height * 0.35),
          nums: [8.3, 14.8, 13.5, 16.2, 18.7, 19.3, 15.9],
          listGradX: [
            "Lun",
            "Mar",
            "Mer",
            "Jeu",
            "Ven",
            "Sam",
            "Dim",
          ],
          colorAxes: Colors.black,
          colorLine: Colors.blue,
          strokeLine: 2.0,
          colorPoint: Colors.blue,
          radiusPoint: 4.0,
          nbGradY: 9,
          minY: 0,
          maxY: 20,
        ),
        Padding(
            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: Text(
              "PRÉCIPITATIONS (mm)",
              style: TextStyle(fontWeight: FontWeight.bold),
              textScaleFactor: 1.6,
            )),
        DiscreteGraphic(
          size: Size(MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height * 0.35),
          nums: [0, 8, 14, 13, 16, 18, 19, 5, 0],
          listGradX: ["", "Lun", "Mar", "Mer", "Jeu", "Ven", "Sam", "Dim", ""],
          colorAxes: Colors.black,
          colorBox: Colors.red,
          boxWidth: 10,
          nbGradY: 14,
          minY: 0,
          maxY: 26,
        ),
      ],
    ));
  }
}
