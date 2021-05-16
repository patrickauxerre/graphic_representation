library graphic_representation;

import 'dart:ui' as ui;
import 'package:flutter/material.dart';

/// Classe interne associée à la classe DiccreteGraphic
/// Permet de dessiner tous les points et lignes en surchargeant la classe paint
/// Hérite de CustomPainter
class _GraphCustomPainter extends CustomPainter {
  _GraphCustomPainter(
      {required this.listNum,
      required this.colorAxes,
      required this.nbGradX,
      required this.nbGradY,
      required this.minY,
      required this.maxY,
      this.colorLine,
      this.colorPoint,
      this.colorBox,
      this.boxWidth});

  List<num> listNum;
  Color colorAxes;
  int nbGradX;
  int nbGradY;
  double minY;
  double maxY;
  Color? colorLine;
  Color? colorPoint;
  Color? colorBox;
  double? boxWidth;

  ///override paint : pour dessiner les axes, points, lignes suivant les valeur contenues dans listNum
  @override
  void paint(Canvas canvas, Size size) {
    ///Amplitude sur l'axe vertical
    var delta = maxY - minY;
    ///Valeur du strokeWidth utilisé pour les barres verticales
    double bw = (boxWidth == null) ? 5 : boxWidth!;
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
          ..strokeWidth = 3
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
        canvas.drawCircle(offSets[i], 4, paint2);
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

/// Classe DiscreteGraphic pour construire un StatelessWidget -> Container de taille size contenant le graphique
/// nums (required) : Liste de int ou double contenant les données chiffrées à representer
/// colorAxes (required) : défini la couleur des axes
/// nbGradY (required) : nombre de graduations sur l'axe vertical
/// minY (optional) : définie la valeur minimum sur l'axe vertical. Si aucune valeur n'est donnée, la valeur minimale de l'axe vertical correspondra au minimum de la liste nums
/// maxY (optional) : définie la valeur maximale sur l'axe vertical. Si aucune valeur n'est donnée, la valeur maximale de l'axe vertical correspondra au maximum de la liste nums
/// colorLine (optional) : couleur de la ligne reliant les points. Si aucune valeur n'est donnée, la ligne ne sera pas présente.
/// colorPoint (optional) : couleur des points sur le graphique. Si aucune valeur n'est donnée, les points ne seront pas présents.
/// colorBox (optional) : couleur des barres verticales. Si aucune valeur n'est donnée, les barres verticales ne seront pas présentes.
/// boxWidth (optional) : largeur des barres verticales. Si aucune valeur n'est donnée, cette largeur vaudra 5.
/// listGradX (optional) : Liste de String contenant les valeurs à placer sur l'axe horizontal. Si aucune valeur n'est passée, aucune valeur n'apparaitra sur l'axe horizontal.

class DiscreteGraphic extends StatelessWidget {
  final Size size;
  final List<num>? nums;
  final Color colorAxes;
  final int nbGradY;
  final double? minY;
  final double? maxY;
  final Color? colorLine;
  final Color? colorPoint;
  final Color? colorBox;
  final double? boxWidth;
  final List<String>? listGradX;

  DiscreteGraphic(
      {required this.size,
      required this.nums,
      required this.colorAxes,
      required this.nbGradY,
      this.minY,
      this.maxY,
      this.colorLine,
      this.colorPoint,
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
                      painter: _GraphCustomPainter(
                          listNum: nums!,
                          colorAxes: colorAxes,
                          colorLine: colorLine,
                          colorPoint: colorPoint,
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
