import 'package:flutter/material.dart';

class GameGrabber extends StatelessWidget {
  const GameGrabber({
    super.key,
    required this.type,
    required this.name,
    required this.x,
    required this.y,
  });

  final Type type;
  final String name;
  final double x;
  final double y;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: x,
      top: y,
      child: Container(
        width: 100,
        height: 100,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black,
        ),
        child: Center(
          child: Text(
            name,
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
