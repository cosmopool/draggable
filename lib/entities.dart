import 'package:flutter/material.dart';

sealed class Entity {
  Entity({
    required this.x,
    required this.y,
    required this.color,
    required this.name,
  });

  double x;
  double y;
  final Color color;
  final String name;

  void move(double x, double y) {
    this.x = x;
    this.y = y;
  }
}

class Fish extends Entity {
  Fish({
    required super.x,
    required super.y,
  }) : super(name: 'Fish', color: Colors.blue);
}

class Dog extends Entity {
  Dog({
    required super.x,
    required super.y,
  }) : super(name: 'Dog', color: Colors.green);
}

class Cat extends Entity {
  Cat({
    required super.x,
    required super.y,
  }) : super(name: 'Cat', color: Colors.yellow);
}

class Grabber {
  Grabber(this.x, this.y, this.attachableType);

  final Type attachableType;
  double x;
  double y;

  @override
  String toString() {
    return 'Grabber($x, $y, $attachableType)';
  }
}
