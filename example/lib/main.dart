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
                "VOLUME DES VENTES",
                style: TextStyle(fontWeight: FontWeight.bold),
                textScaleFactor: 1.6,
              )),
          CircularGraphic(
            context: context,
            nums: [204, 180, 243, 231, 378, 798],
            titles: [
              "Lundi",
              "Mardi",
              "Mercredi",
              "Jeudi",
              "Vendredi",
              "Samedi"
            ],
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
      ),
    );
  }
}
