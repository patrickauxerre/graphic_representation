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

/// Classe interne associée à la classe DiscreteGraphic
/// Permet de dessiner tous les points et lignes en surchargeant la classe paint
/// Hérite de CustomPainter
class _GraphCustomPainter2 extends CustomPainter {
  _GraphCustomPainter2(
      {required this.f,
      required this.nbGradX,
      required this.nbGradY,
      required this.minX,
      required this.maxX,
      required this.minY,
      required this.maxY,
      this.colorAxes,
      this.colorLine,
      this.strokeLine});

  Function f;
  int nbGradX;
  int nbGradY;
  double minX;
  double maxX;
  double minY;
  double maxY;
  Color? colorAxes;
  Color? colorLine;
  double? strokeLine;

  ///override paint : pour dessiner les axes, points, lignes suivant les valeurs contenues dans listNum
  @override
  void paint(Canvas canvas, Size size) {
    ///Initialisation des variables
    var colAxes = (colorAxes == null) ? Colors.black : colorAxes;
    var colLine = (colorLine == null) ? Colors.red : colorLine;
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

    /// Liste des points correspondant à listNum
    List<Offset> offSets = [];

    /// Ajout des points
    for (int j = 0; j <= nbPoints; j++) {
      double x = minX + (j / nbPoints) * deltaX;
      try {
        if (f(x) != null) {
          offSets.add(Offset(j * espacementX,
              size.height - ((f(x) - minY) / deltaY) * size.height));
        }
      } catch (e) {
        print(e);
      }
    }

    /// Tracé des lignes si colorLine != null
    for (int i = 0; i < offSets.length - 1; i++) {
      if (colorLine != null) {
        var paint1 = Paint()
          ..color = colLine!
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

  /// The function to be represented.
  ///
  /// ```dart
  /// f : (x) => x + 1
  /// ```
  final Function f;

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

  /// colors of the graphic.
  ///
  /// Default value : Colors.red
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

  FunctionGraphic({
    required this.size,
    required this.colorAxes,
    required this.f,
    this.nbGradX,
    this.nbGradY,
    this.minX,
    this.maxX,
    this.minY,
    this.maxY,
    this.colorLine,
    this.strokeLine,
  });

  @override
  Widget build(BuildContext context) {
    double miniX = (minX != null) ? minX! : -5;
    double miniY = (minY != null) ? minY! : -5;
    double maxiX = (maxX != null) ? maxX! : 5;
    double maxiY = (maxY != null) ? maxY! : 5;
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
                    f: f,
                    colorAxes: colorAxes,
                    colorLine: colorLine,
                    strokeLine: strokeLine,
                    nbGradX: nbGX,
                    nbGradY: nbGY,
                    minX: miniX,
                    maxX: maxiX,
                    minY: miniY,
                    maxY: maxiY),
              )),
          Stack(children: pos)
        ],
      ),
    );
  }
}

/// Classe interne associée à la classe DiscreteGraphic
/// Permet de dessiner tous les points et lignes en surchargeant la classe paint
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

  ///override paint : pour dessiner les axes, points, lignes suivant les valeurs contenues dans listNum
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
