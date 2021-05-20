# graphic_representation

Easy graphic representation
This package will allow you to make graphic representations very quickly with [Flutter](https://flutter.dev)

<p align="center">
  <img src="https://github.com/catpat44/graphic_representation/raw/main/screenshots/demo.gif" width="300" height="650" />
</p>

## Installation
In the dependencies: section of your `pubspec.yaml, add the following line:

```yaml
dependencies:
    graphic_representation: ^1.0.4
```

## Usage
Import this class :
```dart
import 'package:graphic_representation/graphic_representation.dart';
```

## Example

### Class DiscreteGraphic
Build a StatelessWidget : Container of defined size containing the graphic  
The graphic can contain different elements :  
* Points if colorPoint is defined.
* Lines if colorLine is defined.
* Verticals bars if colorBox is defined.
```dart
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
            strokeLine : 2.0,
            colorPoint: Colors.blue,
            radiusPoint: 3.0,
            nbGradY: 9,
            minY: 0,
            maxY: 16,
          )
```

### Class FunctionGraphic
Build a StatelessWidget : Container of defined size containing the graphic  
The graph represents the functions associated with the property functions and functionsXt / functionsYt for parametrized functions.  
You can represent several functions on the same graph by filling in the corresponding lists.  
```dart
FunctionGraphic(
          size: Size(MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height * 0.5),
          functions: [(x) => exp(-x * x/8), (x) => sin(x) / x, (x) => sin(x/2)],
          functionsXt: [],
          functionsYt: [],
          colorAxes: Colors.black,
          colors: [Colors.purple, Colors.green, Colors.red],
          nbGradX: 11,
          minX: -10,
          maxX: 10,
          minY: -1,
          maxY: 1,
          strokeLine: 3.0,
        )
```
```dart
FunctionGraphic(
              size: Size(MediaQuery.of(context).size.width,
                  MediaQuery.of(context).size.height * 0.35),
              functions: [],
              functionsXt: [(t) => sin(2*t)],
              functionsYt: [(t) => sin(3*t)],
              colorAxes: Colors.black,
              colorsParam: [Colors.purple],
              nbGradX: 11,
              minT: -pi,
              maxT: pi,
              minX: -1,
              maxX: 1,
              minY: -1,
              maxY: 1,
              strokeLine: 3.0,
            )
```

### Class CircularGraphic
Build a StatelessWidget : Container of defined size containing the circular graphic  
The graph represents data in the List nums  
```dart
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
          )
```

### Class CircularGraphic
Build a StatelessWidget : Container of defined size containing the ECC-ECD graphic  
The graph represents data in the List numsX and numsY  
```dart
EccEcdGraphic(
          size: Size(MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height * 0.6),
          numsX: [0, 30, 15, 40, 50, 70, 130],
          numsY: [0, 23, 117, 27, 18, 39, 350],
          pourcentageMode: true,
          nbGradX: 14,
          nbGradY: 21,
          showECC: true,
          showECD: true,
          colorECC: Colors.purple,
          colorECD: Colors.brown,
          strokeLine: 2.0,
          showMedian: true,
          colorMedian: Colors.black,
        )
```

## Buy me a coffee
<a href="https://www.buymeacoffee.com/patrickauxerre">
  <img width="217" height="50" src="https://github.com/catpat44/graphic_representation/blob/main/screenshots/buymecoffee.png?raw=true">
</a>


