import 'dart:math' as math;

import 'package:mvc/entities.dart';

class GameState {
  GameState();
  final _width = 100.0;

  List<Grabber> grabbers = [];

  late List<Entity> entities = [
    Fish(x: 2 * _width, y: 100),
    Dog(x: 3.5 * _width, y: 100),
    Cat(x: 5 * _width, y: 100),
  ];

  Grabber getGrabber(Entity entity) {
    return grabbers.firstWhere((e) => e.attachableType == entity.runtimeType);
  }

  void setHolePosition(Entity entity, double x, double y) {
    final grabber = getGrabber(entity);
    grabber.x = x;
    grabber.y = y;
  }

  (bool, bool) didCollided(
    double x1,
    double y1,
    Entity entity, [
    double? width,
  ]) {
    for (var solid in [...grabbers, ...entities]) {
      if (solid == entity) continue;

      final dx = solid.x - x1;
      final dy = solid.y - y1;
      final distance = math.sqrt(dx * dx + dy * dy);
      if (distance <= (width ?? 100)) {
        if (solid is Grabber && solid.attachableType == entity.runtimeType) {
          return (true, true);
        }
        return (true, false);
      }
    }
    return (false, false);
  }
}
