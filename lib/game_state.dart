import 'dart:math' as math;

import 'package:mvc/entities.dart';

class GameState {
  GameState();

  List<Grabber> grabbers = [];

  Grabber getGrabber(Entity entity) {
    return grabbers.firstWhere((e) => e.attachableType == entity.runtimeType);
  }

  void setHolePosition(Entity entity, double x, double y) {
    final grabber = getGrabber(entity);
    grabber.x = x;
    grabber.y = y;
  }

  bool isInsideHole(double x, double y, Entity entity, [double? width]) {
    final grabber = getGrabber(entity);
    final dx = grabber.x - x;
    final dy = grabber.y - y;
    final distance = math.sqrt(dx * dx + dy * dy);
    return distance <= (width ?? 100);
  }

  bool didCollided(double x1, double y1, Entity entity, [double? width]) {
    for (var grabber in grabbers) {
      if (grabber.attachableType == entity.runtimeType) continue;
      final dx = grabber.x - x1;
      final dy = grabber.y - y1;
      final distance = math.sqrt(dx * dx + dy * dy);
      if (distance <= (width ?? 100)) return true;
    }
    return false;
  }
}
