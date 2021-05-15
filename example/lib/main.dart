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
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            DiscreteGraphic(
              size: Size(MediaQuery.of(context).size.width,
                  MediaQuery.of(context).size.height * 0.5),
              nums: [-1,1, 2, 5, 3, 7, 13, 7,-1],
              listGradX: [
                "",
                "Lun",
                "Mar",
                "Mer",
                "Jeu",
                "Ven",
                "Sam",
                "Dim",
                ""
              ],
              colorAxes: Colors.black,
              nbGradY: 10,
              colorBox: Colors.red,
              colorPoint: Colors.purple,
              colorLine: Colors.blue,
              boxWidth: 15.0,
              minY: 0,
              maxY: 20,
            ),
            Text("COUCOU")
          ],
        ),
    );
  }
}
