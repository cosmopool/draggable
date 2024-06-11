import 'package:flutter/material.dart';
import 'package:mvc/card_widget.dart';
import 'package:mvc/entities.dart';
import 'package:mvc/game_state.dart';
import 'package:mvc/hole_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.gameState,
  });

  final GameState gameState;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GameState get gameState => widget.gameState;

  final width = 100.0;
  final height = 100.0;
  final color = Colors.blue;

  late final entities = [
    Fish(x: 2 * width, y: 100),
    Dog(x: 3.5 * width, y: 100),
    Cat(x: 5 * width, y: 100),
  ];

  @override
  Widget build(BuildContext context) {
    final windowWidth = MediaQuery.of(context).size.width;
    final windowHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          ...entities.map((e) {
            final i =
                entities.indexWhere((b) => e.runtimeType == b.runtimeType);
            final x =
                ((windowWidth - width) / entities.length) * (i + 1) - width;
            final y = windowHeight * .8;

            final type = e.runtimeType;
            gameState.grabbers.add(Grabber(x, y, type));
            return GameHole(type: type, name: e.name, x: x, y: y);
          }),
          ...entities.map((e) {
            return GameCard(
              gameState: widget.gameState,
              entity: e,
              width: width,
              height: height,
            );
          }),
        ],
      ),
    );
  }
}
