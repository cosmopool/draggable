import 'package:flutter/material.dart';
import 'package:draggable_items/card_widget.dart';
import 'package:draggable_items/entities.dart';
import 'package:draggable_items/game_state.dart';
import 'package:draggable_items/hole_widget.dart';

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
  List<Entity> get entities => widget.gameState.entities;

  final width = 100.0;
  final height = 100.0;
  final color = Colors.blue;

  @override
  Widget build(BuildContext context) {
    final windowWidth = MediaQuery.of(context).size.width;
    final windowHeight = MediaQuery.of(context).size.height;

    final button = Padding(
      padding: const EdgeInsets.all(24),
      child: ElevatedButton(
        onPressed: () async {
          if (gameState.isAllGrabbersFull) {
            return _dialogBuilder('Parabéns', 'Parabéns, você passou de fase!');
            // return finishedDialog();
          } else {
            return _dialogBuilder(
              'Atenção',
              'É necessário colocar todos os card em seus respectivos lugares.',
            );
            // return notFinishedYetDialog();
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          minimumSize: const Size(400, 70),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Text('Avançar'),
      ),
    );

    final draggables = Stack(
      children: <Widget>[
        ...entities.map((e) {
          final i = entities.indexWhere((b) => e.runtimeType == b.runtimeType);
          final x = ((windowWidth - width) / entities.length) * (i + 1) - width;
          final y = windowHeight * .78;

          final type = e.runtimeType;
          gameState.grabbers.add(Grabber(x, y, type));
          return GameGrabber(type: type, name: e.name, x: x, y: y);
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
    );

    return Scaffold(
      body: Column(
        children: [
          Expanded(child: draggables),
          button,
        ],
      ),
    );
  }

  Future<void> _dialogBuilder(String title, String content) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
        );
      },
    );
  }
}
