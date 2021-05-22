import 'package:flutter/material.dart';
import 'package:graphic_representation/graphic_representation.dart';

class TableSignPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.only(top: 50.0, bottom: 10.0),
            child: Text(
              "TABLE SIGN",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              textScaleFactor: 1.5,
            )),
        TableSign(
          size: Size(MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height * 0.3),
          rowsLabels: [
            ["x", "-∞", "-1", "0,5", "1", "+∞"],
            ["x - 0,5", "-", "-/0", "+", "+"],
            ["x - 1", "-", "-", "-/0", "+"],
            ["x + 1", "-/0", "+", "+", "+"],
            ["f(x)", "-/0/NAN", "+/0", "-/0/NAN", "+"],
          ],
          fontSize: 18.0,
        )
      ],
    ));
  }
}
