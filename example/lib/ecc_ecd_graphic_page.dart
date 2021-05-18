import 'package:flutter/material.dart';
import 'package:graphic_representation/graphic_representation.dart';

class EccEcdGraphicPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.only(top: 50.0, bottom: 10.0),
            child: Text(
              "ECC - ECD",
              style: TextStyle(fontWeight: FontWeight.bold),
              textScaleFactor: 1.6,
            )),
        EccEcdGraphic(
          size: Size(MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height * 0.6),
          numsX: [0, 30, 15, 40, 50, 70, 130],
          numsY: [0, 23, 117, 27, 18, 39, 350],
          pourcentageMode: true,
          nbGradX: 14,
          nbGradY: 21,
          showECC: true,
          showECD: true,
          colorECC: Colors.purple,
          colorECD: Colors.brown,
          strokeLine: 2.0,
          showMedian: true,
          colorMedian: Colors.black,
        )
      ],
    ));
  }
}
