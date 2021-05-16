# graphic_representation

Easy graphic representation
This package will allow you to make graphic representations very quickly with [Flutter](https://flutter.dev)

![Screenshot](/screenshots/screenshot1.png)

## Installation
In the dependencies: section of your `pubspec.yaml, add the following line:

```yaml
dependencies:
    graphic_representation: ^0.0.3
```

## Usage
Import this class :
```dart
import 'package:graphic_representation/graphic_representation.dart';
```

## Example
```dart
DiscreteGraphic(
            size: Size(MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.height * 0.4),
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
            nbGradY: 10,
            colorPoint: Colors.blue,
            colorLine: Colors.blue,
            minY: 0,
            maxY: 20,
          )
```
```dart
DiscreteGraphic(
            size: Size(MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.height * 0.4),
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
            nbGradY: 10,
            colorBox: Colors.red,
            boxWidth: 15.0,
            minY: 0,
            maxY: 20,
          )
```

