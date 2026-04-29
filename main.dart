import 'dart:collection';

import 'package:flutter/material.dart';
import 'game.dart';

void main() {
  runApp(const MainApp());
}

class Title extends StatelessWidget {
  const Title(this.letter, this.hitType, {super.key});
  final String letter;
  final HitType hitType;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromARGB(255, 14, 141, 141)),
        color: switch (hitType) {
          HitType.hit => const Color.fromARGB(255, 255, 167, 189),
          HitType.miss => Colors.grey,
          HitType.partial => Colors.yellow,
          _ => const Color.fromARGB(255, 167, 255, 248),
        },
      ),
      child: Center(child: Text(letter)),
    );
  }
}

class GamePage extends StatelessWidget {
  GamePage({super.key});
  final Game _game = Game();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        spacing: 0.5,
        children: [
          for (final guess in _game.guesses)
            Row(children: [for (final x in guess) Title(x.char, x.type)]),
        ],
      ),
    );
  }
}

class GuessInput extends StatelessWidget {
  GuessInput({super.key, required this.onSubmitGuess});
  final Function(String) onSubmitGuess;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [Expanded(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: TextField(
            maxLength: 5, 
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(35))
              )
            ),
          ),
        )
      )],
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(child: GamePage()),
        appBar: AppBar(
          title: Align(
            alignment: Alignment.centerLeft,
            child: Text("Aiganym and Zhansaya"),
          ),
        ),
      ),
    );
  }
}
