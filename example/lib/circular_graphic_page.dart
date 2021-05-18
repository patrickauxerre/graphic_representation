import 'package:flutter/material.dart';
import 'package:graphic_representation/graphic_representation.dart';

class CircularGraphicPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.only(top: 50.0, bottom: 10.0),
            child: Text(
              "VOLUME DES VENTES",
              style: TextStyle(fontWeight: FontWeight.bold),
              textScaleFactor: 1.6,
            )),
        CircularGraphic(
          context: context,
          nums: [204, 180, 243, 231, 378, 798],
          titles: ["Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi", "Samedi"],
          colors: [
            Colors.blue,
            Colors.purple,
            Colors.yellow,
            Colors.green,
            Colors.red,
            Colors.brown
          ],
          showPourcentage: true,
          colorsInfo: Colors.white,
        ),
      ],
    ));
  }
}
