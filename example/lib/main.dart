import 'package:example/circular_graphic_page.dart';
import 'package:example/discrete_graphic_page.dart';
import 'package:example/function_graphic_page.dart';
import 'package:flutter/material.dart';

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
      initialRoute: "/",
      routes: <String, WidgetBuilder>{
        "/": (BuildContext context) =>
            MyHomePage(title: 'Graphic_Representation : examples'),
        "discrete_graphic_page": (BuildContext context) =>
            DiscreteGraphicPage(),
        "function_graphic_page": (BuildContext context) =>
            FunctionGraphicPage(),
        "circular_graphic_page": (BuildContext context) =>
            CircularGraphicPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

ElevatedButton myButton(BuildContext context, String title, String pushName) {
  return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, pushName);
      },
      style: ElevatedButton.styleFrom(
        primary: Colors.blueAccent,
      ),
      child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            title,
            textScaleFactor: 2.0,
          )));
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
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          myButton(context, "DiscreteGraphic", "discrete_graphic_page"),
          myButton(context, "FunctionGraphic", "function_graphic_page"),
          myButton(context, "CircularGraphic", "circular_graphic_page")
        ],
      )),
    );
  }
}
