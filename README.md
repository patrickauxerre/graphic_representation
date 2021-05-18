# graphic_representation

Easy graphic representation
This package will allow you to make graphic representations very quickly with [Flutter](https://flutter.dev)

<p align="center">
  <img width="218" height="400" src="https://github.com/catpat44/graphic_representation/blob/main/screenshots/screenshot2.png?raw=true">
</p>

## Installation
In the dependencies: section of your `pubspec.yaml, add the following line:

```yaml
dependencies:
    graphic_representation: ^1.0.0
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
The graph represents the function associated with the property f  
```dart
FunctionGraphic(
            size: Size(MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.height * 0.35),
            f : (x) => sin(x)/x,
            colorAxes: Colors.black,
            colorLine: Colors.purple,
            nbGradX: 11,
            minX: -20,
            maxX: 20,
            minY: -0.3,
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

## Buy me a coffee
<a href="https://www.buymeacoffee.com/patrickauxerre">
  <img width="217" height="50" src="https://github.com/catpat44/graphic_representation/blob/main/screenshots/buymecoffee.png?raw=true">
</a>


