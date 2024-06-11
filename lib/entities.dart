import 'package:flutter/material.dart';

abstract class Vec2 {
  double get x;
  double get y;
}

sealed class Entity extends Vec2 {
  Entity({
    required this.x,
    required this.y,
    required this.color,
    required this.name,
  });

  @override
  double x;
  @override
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
  }) : super(name: 'Dog', color: Colors.purple);
}

class Cat extends Entity {
  Cat({
    required super.x,
    required super.y,
  }) : super(name: 'Cat', color: Colors.yellow);
}

class Grabber extends Vec2 {
  Grabber(this.x, this.y, this.attachableType);

  final Type attachableType;
  @override
  double x;
  @override
  double y;
  bool full = false;
}
