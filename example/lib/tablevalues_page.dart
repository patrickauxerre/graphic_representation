import 'dart:math';

import 'package:flutter/material.dart';
import 'package:graphic_representation/graphic_representation.dart';

class TableValuePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.only(top: 50.0, bottom: 10.0),
            child: Text(
              "TABLE VALUE : f(x) = x² + 1/x",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              textScaleFactor: 1.5,
            )),
        TableValues(
          size: Size(MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height * 0.2),
          functionName: 'x² + 1/x',
          f: (x) => x*x + 1/x,
          numsX: [-2, -1, 0, 1, 2],
          fontSize: 12,
        )
      ],
    ));
  }
}
