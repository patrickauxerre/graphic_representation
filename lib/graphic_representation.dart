library graphic_representation;

import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

num _sumPositiveElement(List<num>? l) {
  num s = 0;
  if (l != null) {
    l.forEach((element) {
      if (element >= 0) {
        s += element;
      }
    });
  }
  return s;
}

num _min(List<num>? l) {
  num min = -123456789;
  if (l != null) {
    min = l[0];
    l.forEach((element) {
      if (element < min) {
        min = element;
      }
    });
  }
  return min;
}

num _max(List<num>? l) {
  num max = 123456789;
  if (l != null) {
    max = l[0];
    l.forEach((element) {
      if (element > max) {
        max = element;
      }
    });
  }
  return max;
}

class _Coord {
  num? x;
  num? y;

  _Coord(this.x, this.y);
}

TextPainter _textpainter(
    Color colorFont, FontWeight fw, double fontSize, String text) {
  TextSpan span = TextSpan(
      style: TextStyle(color: colorFont, fontWeight: fw, fontSize: fontSize),
      text: text);
  TextPainter tp = TextPainter(text: span, textDirection: TextDirection.ltr);
  return tp;
}

/// Classe interne associée à la classe DiscreteGraphic
/// Permet de dessiner tous les points et lignes en surchargeant la classe paint
/// Hérite de CustomPainter
class _GraphCustomPainter1 extends CustomPainter {
  _GraphCustomPainter1(
      {required this.listNum,
      required this.colorAxes,
      required this.nbGradX,
      required this.nbGradY,
      required this.minY,
      required this.maxY,
      this.colorLine,
      this.strokeLine,
      this.colorPoint,
      this.radiusPoint,
      this.colorBox,
      this.boxWidth});

  List<num> listNum;
  Color colorAxes;
  int nbGradX;
  int nbGradY;
  double minY;
  double maxY;
  Color? colorLine;
  double? strokeLine;
  Color? colorPoint;
  double? radiusPoint;
  Color? colorBox;
  double? boxWidth;

  ///override paint : pour dessiner les axes, points, lignes suivant les valeurs contenues dans listNum
  @override
  void paint(Canvas canvas, Size size) {
    ///Amplitude sur l'axe vertical
    var delta = maxY - minY;

    ///Valeur du strokeWidth utilisé pour les barres verticales
    double bw = (boxWidth == null) ? 5 : boxWidth!;

    ///Valeur du strokeLine utilisé pour le tracé des lignes
    double sl = (strokeLine == null) ? 3 : strokeLine!;

    ///Valeur du radius utilisé pour les points
    double rp = (radiusPoint == null) ? 4 : radiusPoint!;

    ///Draw the entire sequence of point as one line.
    final pointMode = ui.PointMode.polygon;

    ///Hauteur d'une graduation verticale
    double gradVertical = size.height / (nbGradY - 1);

    ///Création des différents points puis tracé des lignes verticales avec canvas.drawPoints
    for (int i = 0; i <= nbGradY - 1; i++) {
      var points1 = [
        Offset(0, i * gradVertical.toDouble()),
        Offset(size.width, i * gradVertical.toDouble()),
      ];
      var paint1 = Paint()
        ..color = colorAxes
        ..strokeWidth = 1
        ..strokeCap = StrokeCap.round;
      canvas.drawPoints(pointMode, points1, paint1);
    }

    ///Largeur d'une graduation horizontale
    double gradHorizontal = size.width / (nbGradX - 1);

    ///Création des différents points puis tracé des lignes horizontales avec canvas.drawPoints
    for (int i = 0; i <= nbGradX - 1; i++) {
      var points1 = [
        Offset(i * gradHorizontal.toDouble(), 0),
        Offset(i * gradHorizontal.toDouble(), size.height),
      ];
      var paint1 = Paint()
        ..color = colorAxes
        ..strokeWidth = 1
        ..strokeCap = StrokeCap.round;
      canvas.drawPoints(pointMode, points1, paint1);
    }

    /// index de parcours dans listNum
    int index = 0;

    /// Largeur entre deux points
    var stepX = size.width / (listNum.length - 1);

    /// Liste des points correspondant à listNum
    List<Offset> offSets = [];

    /// Ajout des points
    listNum.forEach((element) {
      offSets.add(Offset(index * stepX,
          size.height - ((element - minY) / delta) * size.height));
      index++;
    });

    /// Tracé des lignes si colorLine != null
    for (int i = 0; i < offSets.length - 1; i++) {
      if (colorLine != null) {
        var paint1 = Paint()
          ..color = colorLine!
          ..strokeWidth = sl
          ..strokeCap = StrokeCap.round;
        if (offSets[i].dy >= 0 &&
            offSets[i].dy <= size.height &&
            offSets[i + 1].dy >= 0 &&
            offSets[i + 1].dy <= size.height) {
          canvas.drawPoints(pointMode, [offSets[i], offSets[i + 1]], paint1);
        }
      }
    }

    /// Tracé des points si colorPoint != null
    /// Tracé des barres verticales si colorBox != null
    for (int i = 0; i <= offSets.length - 1; i++) {
      if (colorPoint != null &&
          offSets[i].dy >= 0 &&
          offSets[i].dy <= size.height) {
        var paint2 = Paint()..color = colorPoint!;
        canvas.drawCircle(offSets[i], rp, paint2);
      }
      if (colorBox != null) {
        var paint3 = Paint()
          ..color = colorBox!
          ..strokeWidth = bw;
        if (offSets[i].dy >= 0 && offSets[i].dy <= size.height) {
          canvas.drawPoints(pointMode,
              [offSets[i], Offset(offSets[i].dx, size.height)], paint3);
        }
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }
}

/// Build a StatelessWidget : Container of defined size containing the graphic
///
/// The graphic can contain different elements :
///
/// Points if colorPoint is defined.
///
/// Lines if colorLine is defined.
///
/// Verticals bars if colorBox is defined.

class DiscreteGraphic extends StatelessWidget {
  /// The size of the container returned.
  ///
  /// ```dart
  /// size: Size(MediaQuery.of(context).size.width,MediaQuery.of(context).size.height * 0.4)
  /// ```
  final Size size;

  /// List of numbers containing the values to be represented.
  ///
  /// ```dart
  /// nums: [1, 2, 5, 3, 7, 13, 7]
  /// ```
  final List<num>? nums;

  /// colors of the axes of the graphic
  ///
  /// ```dart
  /// colorAxes: Colors.black
  /// ```
  final Color colorAxes;

  /// Number of graduations on the vertical axis
  ///
  /// ```dart
  /// nbGradY: 10
  /// ```
  final int nbGradY;

  /// Minimum value of the vertical axis.
  ///
  /// If this value is null, the minimum value on the vertical axis will be the minimum value in the list [nums].
  ///
  /// ```dart
  /// minY: 0
  /// ```
  final double? minY;

  /// Maximum value of the vertical axis.
  ///
  /// If this value is null, the maximum value on the vertical axis will be the maximum value in the list [nums].
  ///
  /// ```dart
  /// maxY: 20
  /// ```
  final double? maxY;

  /// colors of the lines of the graphic. If the value is null, no line will be drawn.
  ///
  /// ```dart
  /// colorLine: Colors.blue
  /// ```
  final Color? colorLine;

  /// Stoke  of the lines.
  ///
  /// Default value : 3.0
  ///
  /// ```dart
  /// strokeLine: 4.0
  /// ```
  final double? strokeLine;

  /// colors of the points of the graphic. If the value is null, no points will be drawn.
  ///
  /// ```dart
  /// colorPoint: Colors.blue
  /// ```
  final Color? colorPoint;

  /// radius of the points.
  ///
  /// Default value : 4.0
  ///
  /// ```dart
  /// radiusPoint: 5.0
  /// ```
  final double? radiusPoint;

  /// colors of the verticals bars of the graphic. If the value is null, no bars will be drawn.
  ///
  /// ```dart
  /// colorBox: Colors.red
  /// ```
  final Color? colorBox;

  /// Stroke width for verticals bars.
  ///
  /// Default value : 5.0
  ///
  /// ```dart
  /// boxWidth: 15.0
  /// ```
  final double? boxWidth;

  /// List of String.
  ///
  /// Strings appearing on the horizontal axis associated with the values of [nums]
  ///
  /// ```dart
  /// listGradX: ["Lun","Mar","Mer","Jeu","Ven","Sam","Dim"]
  /// ```
  final List<String>? listGradX;

  DiscreteGraphic(
      {required this.size,
      required this.nums,
      required this.colorAxes,
      required this.nbGradY,
      this.minY,
      this.maxY,
      this.colorLine,
      this.strokeLine,
      this.colorPoint,
      this.radiusPoint,
      this.colorBox,
      this.boxWidth,
      this.listGradX});

  double _max(List<num> nums) {
    num n = nums[0];
    nums.forEach((element) {
      if (element > n) {
        n = element;
      }
    });
    return n.toDouble();
  }

  double _min(List<num> nums) {
    num n = nums[0];
    nums.forEach((element) {
      if (element < n) {
        n = element;
      }
    });
    return n.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    var nbGradX = (nums != null) ? nums!.length : 1;
    var min = (minY == null && nums != null) ? _min(nums!) : minY;
    var max = (maxY == null && nums != null) ? _max(nums!) : maxY;
    double stepY = (size.height - 40) / (nbGradY - 1);
    List<Positioned> pos = [];
    if (nums != null) {
      for (int i = 0; i <= nbGradY - 1; i++) {
        pos.add(Positioned(
          top: size.height - i * stepY - 40,
          right: size.width - 45,
          child: Text(
            (min! + i * (max! - min) / (nbGradY - 1)).toStringAsFixed(1),
            style: TextStyle(color: colorAxes),
            textScaleFactor: 0.8,
          ),
        ));
      }
      double stepX = (size.width - 100) / (nbGradX - 1);
      for (int i = 0; i <= nbGradX - 1; i++) {
        pos.add(Positioned(
          top: size.height - 25,
          left: i * stepX + 40,
          child: Text(
            (this.listGradX == null)
                ? ""
                : i < listGradX!.length
                    ? listGradX![i]
                    : "",
            style: TextStyle(color: colorAxes),
            textScaleFactor: 0.8,
          ),
        ));
      }
    }
    return Container(
      height: size.height,
      width: size.width,
      child: Stack(
        children: [
          Positioned(
              top: 10,
              left: 50,
              child: (nums != null)
                  ? CustomPaint(
                      size: Size(size.width - 100, size.height - 40),
                      painter: _GraphCustomPainter1(
                          listNum: nums!,
                          colorAxes: colorAxes,
                          colorLine: colorLine,
                          strokeLine: strokeLine,
                          colorPoint: colorPoint,
                          radiusPoint: radiusPoint,
                          colorBox: colorBox,
                          boxWidth: boxWidth,
                          nbGradX: (nums != null) ? nums!.length : 1,
                          nbGradY: nbGradY,
                          minY: min!,
                          maxY: max!),
                    )
                  : Container()),
          Stack(children: pos)
        ],
      ),
    );
  }
}

/// Classe interne associée à la classe FunctionGraphic
/// Permet de dessiner tous les points et lignes en surchargeant la classe paint
/// Hérite de CustomPainter
class _GraphCustomPainter2 extends CustomPainter {
  _GraphCustomPainter2(
      {required this.functions,
      required this.functionsXt,
      required this.functionsYt,
      required this.nbGradX,
      required this.nbGradY,
      required this.minX,
      required this.maxX,
      required this.minY,
      required this.maxY,
      required this.minT,
      required this.maxT,
      this.colorAxes,
      this.colors,
      this.colorsParam,
      this.strokeLine});

  List<Function> functions;
  List<Function> functionsXt;
  List<Function> functionsYt;
  int nbGradX;
  int nbGradY;
  double minX;
  double maxX;
  double minY;
  double maxY;
  double minT;
  double maxT;
  Color? colorAxes;
  List<Color>? colors;
  List<Color>? colorsParam;
  double? strokeLine;

  @override
  void paint(Canvas canvas, Size size) {
    ///Initialisation des variables
    var colAxes = (colorAxes == null) ? Colors.black : colorAxes;
    double sl = (strokeLine == null) ? 3 : strokeLine!;

    ///Amplitude sur l'axe vertical
    var deltaY = maxY - minY;

    ///Draw the entire sequence of point as one line.
    final pointMode = ui.PointMode.polygon;

    ///Hauteur d'une graduation verticale
    double gradVertical = size.height / (nbGradY - 1);

    ///Pinceau pour tracé des axes
    var paint1 = Paint()
      ..color = colAxes!
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;

    ///Création des différents points puis tracé des lignes verticales avec canvas.drawPoints
    for (int i = 0; i <= nbGradY - 1; i++) {
      var points1 = [
        Offset(0, i * gradVertical.toDouble()),
        Offset(size.width, i * gradVertical.toDouble()),
      ];
      canvas.drawPoints(pointMode, points1, paint1);
    }

    ///Largeur d'une graduation horizontale
    double gradHorizontal = size.width / (nbGradX - 1);

    ///Création des différents points puis tracé des lignes horizontales avec canvas.drawPoints
    for (int i = 0; i <= nbGradX - 1; i++) {
      var points1 = [
        Offset(i * gradHorizontal.toDouble(), 0),
        Offset(i * gradHorizontal.toDouble(), size.height),
      ];
      canvas.drawPoints(pointMode, points1, paint1);
    }

    /// espacement entre 2 points
    var espacementX = 1.0;

    /// Amplitude axe horizontal
    var deltaX = maxX - minX;

    /// Largeur entre deux points
    var nbPoints = size.width ~/ espacementX;

    /// Liste des points à tracer
    List<Offset> offSets = [];

    /// Tracé des functions non paramétrées : List functions
    for (int index = 0; index < functions.length; index++) {
      offSets.clear();

      /// Ajout des points
      for (int j = 0; j <= nbPoints; j++) {
        double x = minX + (j / nbPoints) * deltaX;
        try {
          if (functions[index](x) != null) {
            offSets.add(Offset(
                j * espacementX,
                size.height -
                    ((functions[index](x) - minY) / deltaY) * size.height));
          }
        } catch (e) {
          print(e);
        }
      }

      /// Tracé des lignes si colorLine != null
      for (int i = 0; i < offSets.length - 1; i++) {
        Color col = Colors.brown;
        if (colors != null && colors!.length >= index) {
          col = colors![index];
        }
        var paint1 = Paint()
          ..color = col
          ..strokeWidth = sl
          ..strokeCap = StrokeCap.round;
        if (offSets[i].dy >= 0 &&
            offSets[i].dy <= size.height &&
            offSets[i + 1].dy >= 0 &&
            offSets[i + 1].dy <= size.height) {
          canvas.drawPoints(pointMode, [offSets[i], offSets[i + 1]], paint1);
        }
      }
    }

    /// Tracé des fonctions paramétrées : List functionsXt et functionsYt

    for (int index = 0; index < functionsXt.length; index++) {
      offSets.clear();
      if (functionsYt.length > index) {
        /// Ajout des points
        var step = (maxT - minT) / 1000;
        for (int j = 0; j <= 1000; j++) {
          var t = minT + step * j;
          try {
            if (functionsXt[index](t) != null &&
                functionsYt[index](t) != null) {
              offSets.add(Offset(
                  ((functionsXt[index](t) - minX) / deltaX) * size.width,
                  size.height -
                      ((functionsYt[index](t) - minY) / deltaY) * size.height));
            }
          } catch (e) {
            print(e);
          }
        }

        /// Tracé des lignes si colorLine != null
        for (int i = 0; i < offSets.length - 1; i++) {
          Color col = Colors.brown;
          if (colorsParam != null && colorsParam!.length > index) {
            col = colorsParam![index];
          }
          var paint1 = Paint()
            ..color = col
            ..strokeWidth = sl
            ..strokeCap = StrokeCap.round;
          if (offSets[i].dy >= 0 &&
              offSets[i].dy <= size.height &&
              offSets[i + 1].dy >= 0 &&
              offSets[i + 1].dy <= size.height &&
              offSets[i].dx >= 0 &&
              offSets[i].dx <= size.width &&
              offSets[i + 1].dx >= 0 &&
              offSets[i + 1].dx <= size.width) {
            canvas.drawPoints(pointMode, [offSets[i], offSets[i + 1]], paint1);
          }
        }
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }
}

/// Build a StatelessWidget : Container of defined size containing the graphic
///
/// The graph represents the function associated with the property f
class FunctionGraphic extends StatelessWidget {
  /// The size of the container returned.
  ///
  /// ```dart
  /// size: Size(MediaQuery.of(context).size.width,MediaQuery.of(context).size.height * 0.4)
  /// ```
  final Size size;

  /// List of functions to be represented.
  ///
  /// ```dart
  /// functions : [(x) => x*x, (x) => 2*x - 1, (x) => pow(x,3)]
  /// ```
  final List<Function> functions;

  /// List of functions parametrized : return abscissa of the point of the curve with parameter t.
  ///
  /// ```dart
  /// functionsXt: [(t) => t*cos(t),(t) => 10*cos(2*t)*cos(t)]
  /// ```
  final List<Function> functionsXt;

  /// List of functions parametrized : return ordinate of the point of the curve with parameter t.
  ///
  /// ```dart
  /// functionsYt: [(t) => t*sin(t),(t) => 10*cos(2*t)*sin(t)]
  /// ```
  final List<Function> functionsYt;

  /// colors of the axes of the graphic
  ///
  /// Default value : Colors.black
  ///
  /// ```dart
  /// colorAxes: Colors.black
  /// ```
  final Color? colorAxes;

  /// Number of graduations on the horizontal axis
  ///
  /// Default value : 11.
  ///
  /// ```dart
  /// nbGradX: 11
  /// ```
  final int? nbGradX;

  /// Number of graduations on the vertical axis
  ///
  /// Default value : 11.
  ///
  /// ```dart
  /// nbGradY: 11
  /// ```
  final int? nbGradY;

  /// Minimum value of the horizontal axis.
  ///
  /// Default value : -5.
  ///
  /// ```dart
  /// minX: 0
  /// ```
  final double? minX;

  /// Maximum value of the horizontal axis.
  ///
  /// Default value : 5.
  ///
  /// ```dart
  /// maxX: 10
  /// ```
  final double? maxX;

  /// Minimum value of the vertical axis.
  ///
  /// Default value : -5.
  ///
  /// ```dart
  /// minY: 0
  /// ```
  final double? minY;

  /// Maximum value of the vertical axis.
  ///
  /// Default value : 5.
  ///
  /// ```dart
  /// maxY: 20
  /// ```
  final double? maxY;

  /// Minimum value of the parameter t.
  ///
  /// Default value : -2*pi.
  ///
  /// ```dart
  /// minT: -4
  /// ```
  final double? minT;

  /// Maximum value of the parameter t.
  ///
  /// Default value : 2*pi.
  ///
  /// ```dart
  /// maxT: 4
  /// ```
  final double? maxT;

  /// colors of the curves associated with the List functions.
  ///
  /// If no value associated in the list, Colors.brown is provided.
  ///
  /// ```dart
  /// colors: [Colors.blue,Colors.red,Colors.purple]
  /// ```
  final List<Color>? colors;

  /// colors of the curves associated with the List functionsXt and functionsYt.
  ///
  /// If no value associated in the list, Colors.brown is provided.
  ///
  /// ```dart
  /// colorsParam: [Colors.blue,Colors.red]
  /// ```
  final List<Color>? colorsParam;

  /// Stoke  of the lines.
  ///
  /// Default value : 3.0
  ///
  /// ```dart
  /// strokeLine: 4.0
  /// ```
  final double? strokeLine;

  FunctionGraphic({
    required this.size,
    required this.colorAxes,
    required this.functions,
    required this.functionsXt,
    required this.functionsYt,
    this.nbGradX,
    this.nbGradY,
    this.minX,
    this.maxX,
    this.minY,
    this.maxY,
    this.minT,
    this.maxT,
    this.colors,
    this.colorsParam,
    this.strokeLine,
  });

  @override
  Widget build(BuildContext context) {
    double miniX = (minX != null) ? minX! : -5;
    double miniY = (minY != null) ? minY! : -5;
    double miniT = (minT != null) ? minT! : -2 * pi;
    double maxiX = (maxX != null) ? maxX! : 5;
    double maxiY = (maxY != null) ? maxY! : 5;
    double maxiT = (maxT != null) ? maxT! : 2 * pi;
    int nbGX = (nbGradX != null) ? nbGradX! : 11;
    int nbGY = (nbGradY != null) ? nbGradY! : 11;
    double stepY = (size.height - 40) / (nbGY - 1);
    List<Positioned> pos = [];
    for (int i = 0; i <= nbGY - 1; i++) {
      pos.add(Positioned(
        top: size.height - i * stepY - 40,
        right: size.width - 45,
        child: Text(
          (miniY + i * (maxiY - miniY) / (nbGY - 1)).toStringAsFixed(1),
          style: TextStyle(color: colorAxes),
          textScaleFactor: 0.8,
        ),
      ));
    }
    double stepX = (size.width - 100) / (nbGX - 1);
    for (int i = 0; i <= nbGX - 1; i++) {
      pos.add(Positioned(
        top: size.height - 25,
        left: i * stepX + 40,
        child: Text(
          (miniX + i * (maxiX - miniX) / (nbGX - 1)).toStringAsFixed(1),
          style: TextStyle(color: colorAxes),
          textScaleFactor: 0.8,
        ),
      ));
    }
    return Container(
      height: size.height,
      width: size.width,
      child: Stack(
        children: [
          Positioned(
              top: 10,
              left: 50,
              child: CustomPaint(
                size: Size(size.width - 100, size.height - 40),
                painter: _GraphCustomPainter2(
                    functions: functions,
                    functionsXt: functionsXt,
                    functionsYt: functionsYt,
                    colorAxes: colorAxes,
                    colors: colors,
                    colorsParam: colorsParam,
                    strokeLine: strokeLine,
                    nbGradX: nbGX,
                    nbGradY: nbGY,
                    minX: miniX,
                    maxX: maxiX,
                    minY: miniY,
                    maxY: maxiY,
                    minT: miniT,
                    maxT: maxiT),
              )),
          Stack(children: pos)
        ],
      ),
    );
  }
}

/// Classe interne associée à la classe CircularGraphic
/// Permet de dessiner tous les secteurs circulaires en surchargeant la classe paint
/// Hérite de CustomPainter
class _GraphCustomPainter3 extends CustomPainter {
  _GraphCustomPainter3({
    required this.nums,
    required this.titles,
    required this.colors,
  });

  final List<num> nums;
  final List<String> titles;
  final List<Color> colors;

  @override
  void paint(Canvas canvas, Size size) {
    var s = _sumPositiveElement(nums);
    int index = 0;
    double angle = 0;
    nums.forEach((element) {
      if (element > 0) {
        var c = (colors.length > index) ? colors[index] : Colors.black;
        var paint1 = Paint()
          ..color = c
          ..style = PaintingStyle.fill
          ..strokeWidth = 5;
        //draw arc
        canvas.drawArc(
            Offset(0, 0) & Size(size.width * 0.6, size.width * 0.6),
            angle, //radians
            (element / s) * 2 * pi, //radians
            true,
            paint1);
        index++;
        angle += (element / s) * 2 * pi;
      }
    });
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }
}

/// Build a StatelessWidget : Container of defined size containing the circular graphic
///
/// The graph represents data in the List nums
class CircularGraphic extends StatelessWidget {
  /// The context of activity.
  ///
  /// ```dart
  /// context: this.context
  /// ```
  final BuildContext context;

  /// List of numbers containing the values to be represented.
  ///
  /// A negative value will not be taken into account in the representation
  ///
  /// ```dart
  /// nums: [100, 200, 80, 160, 40]
  /// ```
  final List<num> nums;

  /// List of Strings
  ///
  /// Contains values associated with the values of [nums]
  ///
  /// ```dart
  /// titles: ["Lundi","Mardi","Mercredi","Jeudi","Vendredi"]
  /// ```
  final List<String> titles;

  /// colors of the sectors of the circular graphic
  ///
  /// ```dart
  /// colors: [Colors.black,Colors.grey,Colors.cyan,Colors.green,Colors.red]
  /// ```
  final List<Color> colors;

  /// boolean to indicate if the percentages should be visible
  ///
  /// default value : false
  ///
  /// ```dart
  /// colorInfo: Colors.white
  /// ```
  final bool? showPourcentage;

  /// color of informations (number and pourcentage) in each sector
  ///
  /// default value : Colors.black
  ///
  /// ```dart
  /// colorInfo: Colors.white
  /// ```
  final Color? colorsInfo;

  CircularGraphic({
    required this.context,
    required this.nums,
    required this.titles,
    required this.colors,
    this.showPourcentage,
    this.colorsInfo,
  });

  @override
  Widget build(BuildContext context) {
    bool showp = (showPourcentage == null) ? false : showPourcentage!;
    Color colInfo = (colorsInfo == null) ? Colors.black : colorsInfo!;
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.width;
    List<Positioned> pos = [];
    var s = _sumPositiveElement(nums);
    double beta = 0;
    double rayon = w * 0.3;
    nums.forEach((element) {
      if (element > 0 && showp) {
        var angle = (element / s) * 2 * pi;
        String pourcentage = ((element / s) * 100).toStringAsFixed(1) + "%";
        pos.add(Positioned(
            top: rayon + sin(beta + angle / 2) * rayon * 0.6,
            left: w * 0.5 +
                cos(beta + angle / 2) * rayon * 0.6 -
                pourcentage.length * w * 0.035 / 4,
            child: Text(pourcentage,
                style: TextStyle(
                    color: colInfo,
                    fontWeight: FontWeight.bold,
                    fontSize: w * 0.035))));
        beta += angle;
      }
    });
    List<Container> containers = [];
    for (int i = 0; i < nums.length; i++) {
      if (nums[i] > 0) {
        containers.add(Container(
          width: w * 0.90,
          height: w * 0.08,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(left: 20),
                width: w * 0.05,
                height: w * 0.05,
                color: (i < colors.length) ? colors[i] : Colors.black,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  titles[i] + " (${nums[i]})",
                  style: TextStyle(fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
        ));
      }
    }
    pos.add(Positioned(
        top: w * 0.63,
        left: w * 0.05,
        child: Container(
          width: w * 0.90,
          height: w * 0.35,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.black, width: 2.0),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: containers,
            ),
          ),
        )));
    return Container(
      width: w,
      height: h,
      child: Stack(
        children: [
          Positioned(
              top: 0,
              left: MediaQuery.of(context).size.width * 0.2,
              child: CustomPaint(
                size: Size(MediaQuery.of(context).size.width,
                    MediaQuery.of(context).size.width),
                painter: _GraphCustomPainter3(
                    nums: nums, titles: titles, colors: colors),
              )),
          Stack(children: pos)
        ],
      ),
    );
  }
}

/// Classe interne associée à la classe FunctionGraphic
/// Permet de dessiner tous les points et lignes en surchargeant la classe paint
/// Hérite de CustomPainter
class _GraphCustomPainter4 extends CustomPainter {
  _GraphCustomPainter4(
      {required this.numsX,
      required this.numsY,
      this.nbGradX,
      this.nbGradY,
      this.colorAxes,
      this.showECC,
      this.showECD,
      this.colorECC,
      this.colorECD,
      this.strokeLine,
      this.showMedian,
      this.colorMedian});

  final List<num> numsX;
  final List<num> numsY;
  final int? nbGradX;
  final int? nbGradY;
  final Color? colorAxes;
  final bool? showECC;
  final bool? showECD;
  final Color? colorECC;
  final Color? colorECD;
  final double? strokeLine;
  final bool? showMedian;
  final Color? colorMedian;

  @override
  void paint(Canvas canvas, Size size) {
    ///Initialisation des variables
    var nbGX = (nbGradX == null) ? 11 : nbGradX;
    var nbGY = (nbGradY == null) ? 11 : nbGradY;
    var colAxes = (colorAxes == null) ? Colors.black : colorAxes;
    var colECC = (colorECC == null) ? Colors.green : colorECC;
    var colECD = (colorECD == null) ? Colors.red : colorECD;
    var showEcc = (showECC == null) ? true : showECC;
    var showEcd = (showECD == null) ? false : showECD;
    double sl = (strokeLine == null) ? 3 : strokeLine!;
    var showMed = (showMedian == null) ? false : showMedian;
    var colMedian = (colorMedian == null) ? Colors.red : colorMedian;

    List<_Coord> coords = [];
    for (int i = 0; i < numsX.length; i++) {
      coords.add(_Coord(numsX[i], numsY[i]));
    }
    coords.sort((a, b) => a.x!.compareTo(b.x!));
    coords.forEach((element) {
      print(element.x);
      print(element.y);
    });

    ///Amplitude sur l'axe horizontal
    var deltaX = _max(numsX) - _min(numsX);

    ///Draw the entire sequence of point as one line.
    final pointMode = ui.PointMode.polygon;

    ///Hauteur d'une graduation verticale
    double gradVertical = size.height / (nbGY! - 1);

    ///Pinceau pour tracé des axes
    var paint1 = Paint()
      ..color = colAxes!
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;

    ///Création des différents points puis tracé des lignes verticales avec canvas.drawPoints
    for (int i = 0; i <= nbGY - 1; i++) {
      var points1 = [
        Offset(0, i * gradVertical.toDouble()),
        Offset(size.width, i * gradVertical.toDouble()),
      ];
      canvas.drawPoints(pointMode, points1, paint1);
    }

    ///Largeur d'une graduation horizontale
    double gradHorizontal = size.width / (nbGX! - 1);

    ///Création des différents points puis tracé des lignes horizontales avec canvas.drawPoints
    for (int i = 0; i <= nbGX - 1; i++) {
      var points1 = [
        Offset(i * gradHorizontal.toDouble(), 0),
        Offset(i * gradHorizontal.toDouble(), size.height),
      ];
      canvas.drawPoints(pointMode, points1, paint1);
    }

    if (numsX.length == numsY.length) {
      /// index de parcours dans listNum
      int index = 0;

      /// cumul des valeurs de X
      num cumulY = 0;

      /// Liste des points correspondant à ECC
      List<Offset> offSets = [];

      /// Liste des points correspondant à ECD
      List<Offset> offSets2 = [];

      /// Ajout des points ECC
      coords.forEach((element) {
        cumulY += element.y!;
        offSets.add(Offset(((element.x! - _min(numsX)) / deltaX) * size.width,
            size.height - (cumulY / _sumPositiveElement(numsY)) * size.height));
        index++;
      });

      cumulY = _sumPositiveElement(numsY);
      index = 0;

      /// Ajout des points ECD
      coords.forEach((element) {
        cumulY -= element.y!;
        offSets2.add(Offset(((element.x! - _min(numsX)) / deltaX) * size.width,
            size.height - (cumulY / _sumPositiveElement(numsY)) * size.height));
        index++;
      });

      /// Tracé des lignes ECC
      if (showEcc!) {
        for (int i = 0; i < offSets.length - 1; i++) {
          var paint1 = Paint()
            ..color = colECC!
            ..strokeWidth = sl
            ..strokeCap = StrokeCap.round;
          if (offSets[i].dy >= 0 &&
              offSets[i].dy <= size.height &&
              offSets[i + 1].dy >= 0 &&
              offSets[i + 1].dy <= size.height) {
            canvas.drawPoints(pointMode, [offSets[i], offSets[i + 1]], paint1);
          }
        }
      }

      /// Tracé des lignes ECD
      if (showEcd!) {
        for (int i = 0; i < offSets2.length - 1; i++) {
          var paint2 = Paint()
            ..color = colECD!
            ..strokeWidth = sl
            ..strokeCap = StrokeCap.round;
          if (offSets2[i].dy >= 0 &&
              offSets2[i].dy <= size.height &&
              offSets2[i + 1].dy >= 0 &&
              offSets2[i + 1].dy <= size.height) {
            canvas.drawPoints(
                pointMode, [offSets2[i], offSets2[i + 1]], paint2);
          }
        }
      }

      /// Tracé des points ECC
      if (showEcc) {
        for (int i = 0; i <= offSets.length - 1; i++) {
          var paint2 = Paint()..color = colECC!;
          canvas.drawCircle(offSets[i], 4.0, paint2);
        }
      }

      /// Tracé des points ECD
      if (showEcd) {
        for (int i = 0; i <= offSets2.length - 1; i++) {
          var paint2 = Paint()..color = colECD!;
          canvas.drawCircle(offSets2[i], 4.0, paint2);
        }
      }

      /// Calcul et affichage de la médiane
      if (showMed!) {
        var indexCible = 0;
        num cumul = 0;
        while (cumul < _sumPositiveElement(numsY) / 2) {
          cumul += coords[indexCible].y!;
          indexCible++;
        }
        indexCible--;
        print(indexCible);
        num xA = coords[indexCible - 1].x!;
        num cum = 0;
        for (int i = 0; i <= indexCible - 1; i++) {
          cum += coords[i].y!;
        }
        num yA = cum;
        num xB = coords[indexCible].x!;
        num yB = coords[indexCible].y! + cum;
        double a = (yB - yA) / (xB - xA);
        double b = yA - a * xA;
        double med = (_sumPositiveElement(numsY) / 2 - b) / a;
        print(med);
        var offSetMedian = Offset(
            ((med - _min(numsX)) / deltaX) * size.width, 0.5 * size.height);
        var paint = Paint()..color = colMedian!;
        canvas.drawCircle(offSetMedian, 4.0, paint);
        var tp = _textpainter(
            colMedian, FontWeight.bold, 20, "m = " + med.toStringAsFixed(1));
        tp.layout();
        tp.paint(canvas, Offset(offSetMedian.dx + 15, offSetMedian.dy - 12));
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }
}

/// Build a StatelessWidget : Container of defined size containing the ECC-ECD graphic
///
/// The graph represents data in the List numsX and numsY
class EccEcdGraphic extends StatelessWidget {
  /// The size of the container returned.
  ///
  /// ```dart
  /// size: Size(MediaQuery.of(context).size.width,MediaQuery.of(context).size.height * 0.4)
  /// ```
  final Size size;

  /// List of numbers containing the values of the x-coordinates of the points represented.
  ///
  /// ```dart
  /// numsX: [0, 10, 20, 30, 50,70,100]
  /// ```
  final List<num> numsX;

  /// List of numbers containing the values of the y-coordinates of the points represented.
  ///
  /// A negative value will not be taken into account in the representation
  ///
  /// ```dart
  /// numsY: [38, 53, 86, 27, 18, 15, 10]
  /// ```
  final List<num> numsY;

  /// Number of graduations on the horizontal axis
  ///
  /// Default value : 11.
  ///
  /// ```dart
  /// nbGradX: 11
  /// ```
  final int? nbGradX;

  /// Number of graduations on the vertical axis
  ///
  /// Default value : 11.
  ///
  /// ```dart
  /// nbGradY: 11
  /// ```
  final int? nbGradY;

  /// colors of the axes of the graphic
  ///
  /// Default value : Colors.black
  ///
  /// ```dart
  /// colorAxes: Colors.black
  /// ```
  final Color? colorAxes;

  /// boolean to indicate if the ECC graphic must be visible
  ///
  /// default value : true
  ///
  /// ```dart
  /// showECC: false
  /// ```
  final bool? showECC;

  /// boolean to indicate if the ECD graphic must be visible
  ///
  /// default value : false
  ///
  /// ```dart
  /// showECD: true
  /// ```
  final bool? showECD;

  /// colors of the lines of the ECC graphic
  ///
  /// Default value : Colors.green
  ///
  /// ```dart
  /// colorECC: Colors.purple
  /// ```
  final Color? colorECC;

  /// colors of the lines of the ECD graphic
  ///
  /// Default value : Colors.red
  ///
  /// ```dart
  /// colorECD: Colors.blue
  /// ```
  final Color? colorECD;

  /// Stoke  of the lines.
  ///
  /// Default value : 3.0
  ///
  /// ```dart
  /// strokeLine: 4.0
  /// ```
  final double? strokeLine;

  /// boolean to indicate if the value of median must be visible
  ///
  /// default value : false
  ///
  /// ```dart
  /// pourcentageMode: true
  /// ```
  final bool? pourcentageMode;

  /// boolean to indicate if the value of median must be visible
  ///
  /// default value : false
  ///
  /// ```dart
  /// showECD: true
  /// ```
  final bool? showMedian;

  /// colors of median info
  ///
  /// Default value : Colors.red
  ///
  /// ```dart
  /// colorMedian: Colors.black
  /// ```
  final Color? colorMedian;

  EccEcdGraphic(
      {required this.size,
      required this.numsX,
      required this.numsY,
      this.nbGradX,
      this.nbGradY,
      this.colorAxes,
      this.showECC,
      this.showECD,
      this.colorECC,
      this.colorECD,
      this.strokeLine,
      this.pourcentageMode,
      this.showMedian,
      this.colorMedian});

  @override
  Widget build(BuildContext context) {
    int nbGX = (nbGradX != null) ? nbGradX! : 11;
    int nbGY = (nbGradY != null) ? nbGradY! : 11;
    double stepY = (size.height - 40) / (nbGY - 1);
    List<Positioned> pos = [];
    bool? pm = (pourcentageMode == null) ? false : pourcentageMode;
    var maxiY = (pm!) ? 100 : _sumPositiveElement(numsY);
    for (int i = 0; i <= nbGY - 1; i++) {
      String prc = (pm) ? "%" : "";
      pos.add(Positioned(
        top: size.height - i * stepY - 36,
        right: size.width - 45,
        child: Text(
          (i * maxiY / (nbGY - 1)).toStringAsFixed(1) + prc,
          style: TextStyle(color: colorAxes),
          textScaleFactor: 0.6,
        ),
      ));
    }
    double stepX = (size.width - 100) / (nbGX - 1);
    for (int i = 0; i <= nbGX - 1; i++) {
      pos.add(Positioned(
        top: size.height - 25,
        left: i * stepX + 40,
        child: Text(
          (_min(numsX) + i * (_max(numsX) - _min(numsX)) / (nbGX - 1))
              .toStringAsFixed(1),
          style: TextStyle(color: colorAxes),
          textScaleFactor: 0.6,
        ),
      ));
    }
    return Container(
      width: size.width,
      height: size.height,
      child: Stack(
        children: [
          Positioned(
              top: 10,
              left: 50,
              child: CustomPaint(
                size: Size(size.width - 100, size.height - 40),
                painter: _GraphCustomPainter4(
                    numsX: numsX,
                    numsY: numsY,
                    nbGradX: nbGradX,
                    nbGradY: nbGradY,
                    colorAxes: colorAxes,
                    showECC: showECC,
                    showECD: showECD,
                    colorECC: colorECC,
                    colorECD: colorECD,
                    strokeLine: strokeLine,
                    showMedian: showMedian,
                    colorMedian: colorMedian),
              )),
          Stack(children: pos)
        ],
      ),
    );
  }
}

class TableValues extends StatelessWidget {
  /// The size of the container returned.
  ///
  /// ```dart
  /// size: Size(MediaQuery.of(context).size.width,MediaQuery.of(context).size.height * 0.2)
  /// ```
  final Size size;

  /// The String describing the function.
  ///
  /// default value : "f(x)"
  ///
  /// ```dart
  /// functionName: 'x² - 3'
  /// ```
  final String? functionName;

  /// The function : if numsY is null, the y-values will be calculated with the expression
  ///
  /// ```dart
  /// f: '(x) => pow(x,3) - 2'
  /// ```
  final Function? f;

  /// The x-values of the table values.
  ///
  /// ```dart
  /// numsX: [-2,-1.5,-1,-0.5,0,0.5,1,1.5,2]
  /// ```
  final List<num> numsX;

  /// The y-values of the table values.
  ///
  /// ```dart
  /// numsY: [4,2.25,1,0.25,0,0.25,1,2.25,4]
  /// ```
  final List<num>? numsY;

  /// The fontsize for String in table value.
  ///
  /// ```dart
  /// fontSize: 16.0
  /// ```
  final double fontSize;

  TableValues(
      {required this.size,
      this.functionName,
      this.f,
      required this.numsX,
      this.numsY,
      required this.fontSize});

  @override
  Widget build(BuildContext context) {
    List<Container> containers1 = [];
    containers1.add(Container(
      height: size.height * 0.5,
      color: Colors.grey,
      child: Center(
          child: Text(
        "x",
        style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
      )),
    ));
    numsX.forEach((element) {
      containers1.add(Container(
        height: size.height * 0.5,
        child: Center(
            child: Text(
          element.toString(),
          style: TextStyle(fontSize: fontSize),
        )),
      ));
    });
    TableRow tr1 = TableRow(
      children: containers1,
    );
    List<Container> containers2 = [];
    containers2.add(Container(
      height: size.height * 0.5,
      color: Colors.grey,
      child: Center(
          child: Text(
        (functionName != null) ? functionName! : "f(x)",
        style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      )),
    ));
    for (int i = 0; i < numsX.length; i++) {
      containers2.add(Container(
        color: (f!(numsX[i]).toString() == "NaN" ||
                f!(numsX[i]).toString().contains("Infinity"))
            ? Colors.redAccent
            : Colors.white,
        height: size.height * 0.5,
        child: Center(
            child: Text(
          (numsY != null && numsY!.length > i)
              ? numsY![i].toString()
              : (f != null &&
                      f!(numsX[i]).toString() != "NaN" &&
                      !f!(numsX[i]).toString().contains("Infinity"))
                  ? double.parse(f!(numsX[i]).toString()).toStringAsFixed(2)
                  : "",
          style: TextStyle(fontSize: fontSize),
        )),
      ));
    }
    TableRow tr2 = TableRow(
      children: containers2,
    );
    return Container(
      width: size.width,
      height: size.height,
      child: Stack(
        children: [
          Positioned(
              left: size.width * 0.05,
              right: size.width * 0.05,
              child: Container(
                width: size.width * 0.9,
                height: size.height,
                child: Table(
                  border: TableBorder.all(),
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: <TableRow>[tr1, tr2],
                ),
              ))
        ],
      ),
    );
  }
}

/// Classe interne associée à la classe DiscreteGraphic
/// Permet de dessiner tous les points et lignes en surchargeant la classe paint
/// Hérite de CustomPainter
class _GraphCustomPainter5 extends CustomPainter {
  _GraphCustomPainter5(
      {required this.rowsLabels,
      this.fontSize,
      this.colorFont,
      this.colorSigns,
      this.strokeWidth,
      this.colorLine});

  List<List<String>> rowsLabels;
  double? fontSize;
  Color? colorFont;
  Color? colorSigns;
  double? strokeWidth;
  Color? colorLine;

  ///override paint : pour dessiner les axes, points, lignes suivant les valeurs contenues dans listNum
  @override
  void paint(Canvas canvas, Size size) {
    ///Initialisation des variables
    double fs = (fontSize != null) ? fontSize! : 14.0;
    Color cf = (colorFont != null) ? colorFont! : Colors.black;
    Color cs = (colorSigns != null) ? colorSigns! : Colors.red;
    double sw = (strokeWidth != null) ? strokeWidth! : 2.0;
    Color cl = (colorLine != null) ? colorLine! : Colors.black;

    ///Draw the entire sequence of point as one line.
    final pointMode = ui.PointMode.polygon;

    ///Définition du pinceau pour les lignes
    var paint1 = Paint()
      ..color = cl
      ..strokeWidth = sw
      ..strokeCap = StrokeCap.round;

    List<List<Offset>> offsets = [];

    ///Création des différents points puis tracé des lignes verticales avec canvas.drawPoints
    var stepX = (size.width - 20) / (rowsLabels[0].length - 1);
    var stepY = size.height / (rowsLabels.length);
    for (int i = 0; i <= rowsLabels.length; i++) {
      List<Offset> offs = [];
      for (int j = 0; j <= rowsLabels[0].length - 1; j++) {
        offs.add(Offset(10 + j * stepX, stepY * i));
      }
      offsets.add(offs);
    }
    print(stepX);
    print(stepY);
    print(offsets.length);
    print(offsets);
    offsets.forEach((element) {
      print(element);
      canvas.drawPoints(pointMode, [element.first, element.last], paint1);
    });
    canvas.drawPoints(pointMode, [offsets[0][0], offsets.last[0]], paint1);
    canvas.drawPoints(pointMode, [offsets[0][1], offsets.last[1]], paint1);
    canvas.drawPoints(pointMode, [offsets[0].last, offsets.last.last], paint1);
    for (int k = 1; k <= offsets[0].length - 1; k++) {
      canvas.drawPoints(pointMode, [offsets[1][k], offsets.last[k]], paint1);
    }

    ///Ajout des labels première ligne
    for (int i = 1; i <= offsets[0].length - 1; i++) {
      var tp = _textpainter(cf, FontWeight.bold, fs, rowsLabels[0][i]);
      tp.layout();
      if (i == 1) {
        tp.paint(
            canvas,
            Offset(
                offsets[0][i].dx + 3, offsets[0][i].dy + stepY / 2 - fs / 2));
      } else {
        if (i == offsets[0].length - 1) {
          tp.paint(
              canvas,
              Offset(offsets[0][i].dx - tp.width - 3,
                  offsets[0][i].dy + stepY / 2 - fs / 2));
        } else {
          tp.paint(
              canvas,
              Offset(offsets[0][i].dx - tp.width / 2,
                  offsets[0][i].dy + stepY / 2 - fs / 2));
        }
      }
    }

    ///Ajout des autres labels
    var tp = _textpainter(cf, FontWeight.bold, fs, rowsLabels[0][0]);
    tp.layout();
    tp.paint(canvas, Offset(10 + stepX / 2 - tp.width / 2, stepY / 2 - tp.width / 2));
    for (int i = 1; i < rowsLabels.length; i++) {
      for (int j = 0; j < rowsLabels[i].length; j++) {
        var tp = _textpainter((j > 0) ? cs : cf, FontWeight.bold, fs,
            rowsLabels[i][j].split("/")[0]);
        tp.layout();
        tp.paint(
            canvas,
            Offset(10 + stepX * j + stepX / 2 - tp.width / 2,
                stepY * i + stepY / 2 - fs / 2));

        /// Placement des zéros
        if ((rowsLabels[i][j].split("/").length > 1 &&
                rowsLabels[i][j].split("/")[1] == "0")) {
          print("TOTO");
          var tp = _textpainter(cf, FontWeight.bold, fs*1.4,
              "0");
          tp.layout();
          tp.paint(
              canvas,
              Offset(10 + stepX * (j+1)- tp.width / 2,
                  stepY * i + stepY / 2 - tp.height/ 2));
        }
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }
}

class TableSign extends StatelessWidget {
  /// The size of the container returned.
  ///
  /// ```dart
  /// size: Size(MediaQuery.of(context).size.width,MediaQuery.of(context).size.height * 0.3)
  /// ```
  final Size size;

  /// The String describing the function.
  ///
  /// ```dart
  /// rowsLabels: 'x² - 3'
  /// ```
  final List<List<String>> rowsLabels;

  /// The fontsize for String in table value.
  ///
  /// default value : 14.0
  ///
  /// ```dart
  /// fontSize: 16.0
  /// ```
  final double? fontSize;

  /// The color of font for labels in table sign.
  ///
  /// default value : Colors.black
  ///
  /// ```dart
  /// colorFont: Colors.red
  /// ```
  final Color? colorFont;

  /// The color of font for signs in table sign.
  ///
  /// default value : Colors.black
  ///
  /// ```dart
  /// colorSigns: Colors.red
  /// ```
  final Color? colorSigns;

  /// The width of the  lines in the table sign.
  ///
  /// default value : 2.0
  ///
  /// ```dart
  /// strokeWidth: 3.0
  /// ```
  final double? strokeWidth;

  /// The color of line of table sign.
  ///
  /// default value : Colors.black
  ///
  /// ```dart
  /// colorLine: Colors.red
  /// ```
  final Color? colorLine;

  TableSign(
      {required this.size,
      required this.rowsLabels,
      this.fontSize,
      this.colorFont,
      this.colorSigns,
      this.strokeWidth,
      this.colorLine});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height,
      child: Stack(
        children: [
          Positioned(
              top: 0,
              left: 0,
              child: CustomPaint(
                size: Size(size.width, size.height),
                painter: _GraphCustomPainter5(
                    rowsLabels: rowsLabels,
                    fontSize: fontSize,
                    colorFont: colorFont,
                    strokeWidth: strokeWidth,
                    colorLine: colorLine),
              )),
        ],
      ),
    );
  }
}
