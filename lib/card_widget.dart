import 'package:flutter/material.dart';
import 'package:mvc/entities.dart';
import 'package:mvc/game_state.dart';

class GameCard extends StatefulWidget {
  const GameCard({
    super.key,
    required this.entity,
    required this.width,
    required this.height,
    required this.gameState,
  });

  final GameState gameState;
  final Entity entity;
  final double width;
  final double height;

  @override
  State<GameCard> createState() => _GameCardState();
}

class _GameCardState extends State<GameCard> {
  Entity get entity => widget.entity;
  double get width => widget.width;
  double get height => widget.height;
  GameState get gameState => widget.gameState;

  late Color color = widget.entity.color;
  late final radius = width / 2;
  bool validPlace = false;
  bool visible = true;
  BoxBorder? border;

  @override
  Widget build(BuildContext context) {
    if (!visible) return const SizedBox.shrink();
    final draggingColor = entity.color.withOpacity(.5);
    return Positioned(
      left: entity.x,
      top: entity.y,
      child: Draggable(
        feedback: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          decoration: BoxDecoration(
            color: draggingColor,
            border: border,
          ),
          width: width,
          height: height,
        ),
        onDragUpdate: ((details) {
          final x = details.localPosition.dx;
          final y = details.localPosition.dy;

          final isInside = gameState.isInsideHole(x, y, entity);
          if (isInside && border != null) return;
          if (isInside) {
            setState(() => border = Border.all(color: Colors.red, width: 5));
          } else {
            setState(() => border = null);
          }
        }),
        onDraggableCanceled: (_, offset) {
          double x = offset.dx, y = offset.dy;
          if (gameState.isInsideHole(x, y, entity)) {
            final grabber = gameState.getGrabber(entity);
            x = grabber.x;
            y = grabber.y;
          }
          if (gameState.didCollided(x, y, entity)) return;
          setState(() => entity.move(x, y));
        },
        child: Container(
          width: width,
          height: height,
          color: entity.color,
          child: Center(
            child: Text(entity.name),
          ),
        ),
      ),
    );
  }
}