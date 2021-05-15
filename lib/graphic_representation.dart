library graphic_representation;

import 'dart:ui' as ui;
import 'package:flutter/material.dart';

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

  @override
  void paint(Canvas canvas, Size size) {
    var delta = maxY - minY;
    double bw = (boxWidth == null) ? 5 : boxWidth!;
    final pointMode = ui.PointMode.polygon;
    double gradVertical = size.height / (nbGradY - 1);
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
    double gradHorizontal = size.width / (nbGradX - 1);
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
      int index = 0;
      var stepX = size.width / (listNum.length - 1);
      List<Offset> offSets = [];
      listNum.forEach((element) {
        offSets.add(Offset(index * stepX,
            size.height - ((element - minY) / delta) * size.height));
        index++;
      });
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
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }
}

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
                      size: Size(size.width - 100, size.height-40),
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
