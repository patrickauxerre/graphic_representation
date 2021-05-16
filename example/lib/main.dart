import 'package:flutter/material.dart';
import 'package:graphic_representation/graphic_representation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Graphic_Representation : example'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
              child: Text(
                "PRECIPITATIONS (mm)",
                style: TextStyle(fontWeight: FontWeight.bold),
                textScaleFactor: 1.6,
              )),
          DiscreteGraphic(
            size: Size(MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.height * 0.35),
            nums: [1, 2, 5, 3, 7, 13, 7],
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
            radiusPoint: 3.0,
            nbGradY: 9,
            minY: 0,
            maxY: 16,
          ),
          Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
              child: Text(
                "Températures (°C)",
                style: TextStyle(fontWeight: FontWeight.bold),
                textScaleFactor: 1.6,
              )),
          DiscreteGraphic(
            size: Size(MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.height * 0.35),
            nums: [
              3.1,
              2.2,
              7.1,
              12.7,
              14.9,
              18,
              19.8,
              21.8,
              19.7,
              14.3,
              9.4,
              5.1
            ],
            listGradX: [
              "J",
              "F",
              "M",
              "A",
              "M",
              "J",
              "J",
              "A",
              "S",
              "O",
              "N",
              "D"
            ],
            colorAxes: Colors.black,
            nbGradY: 14,
            colorBox: Colors.red,
            boxWidth: 10.0,
            minY: 0,
            maxY: 26,
          ),
        ],
      ),
    );
  }
}
