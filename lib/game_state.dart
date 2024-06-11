import 'dart:math' as math;

import 'package:draggable_items/entities.dart';

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

  /// Check if [entity] collided with other [Entity] or [Grabber]
  ///
  /// The first [bool] returns if [entity] collided with any other solid.
  /// The second [bool] returns if [entity] collided with it's right [Grabber]
  (bool, bool) didCollided(
    double x1,
    double y1,
    Entity entity, [
    double? width,
  ]) {
    final a = [...grabbers, ...entities];
    for (var solid in a) {
      if (solid == entity) continue;

      final dx = solid.x - x1;
      final dy = solid.y - y1;
      final distance = math.sqrt(dx * dx + dy * dy);
      final collided = distance <= (width ?? 100);
      if (!collided) {
        if (solid is Grabber && solid.attachableType == entity.runtimeType) {
          solid.full = false;
        }
        continue;
      } else {
        if (solid is! Grabber) return (true, false);
        if (solid.attachableType == entity.runtimeType) {
          solid.full = true;
          return (true, true);
        }
        return (true, false);
      }
    }
    return (false, false);
  }
}
