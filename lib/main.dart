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
        border: Border.all(color: const Color.fromARGB(255, 51, 8, 151)),
        color: switch (hitType) {
          HitType.hit => Colors.green,
          HitType.miss => Colors.grey,
          HitType.partial => const Color.fromARGB(255, 194, 176, 9),
          _ => const Color.fromARGB(255, 255, 255, 255),
        },
      ),
      child: Center(child: Text(letter)),
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

class GamePage extends StatelessWidget {
  GamePage({super.key});
  final Game _game = Game();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        spacing: 5.0,
        children: [
          for (final guess in _game.guesses)
            Row(children: [for (final x in guess) Title(x.char, x.type)]),
          GuessInput(
            onSubmitGuess: (guess) {
              print(guess);
            },
          ),
        ],
      ),
    );
  }
}

class GuessInput extends StatelessWidget {
  GuessInput({super.key, required this.onSubmitGuess});
  final Function(String) onSubmitGuess;

  final FocusNode _focus = FocusNode();
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              maxLength: 5,
              focusNode: _focus,
              controller: _controller,
              autofocus: true,
              onSubmitted: (Text) {
                onSubmitGuess(Text.trim());
                _focus.requestFocus();
                _controller.clear();
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(35)),
                ),
              ),
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.arrow_forward),
          onPressed: () {
            final Text = _controller.text.trim();
            if (Text.isNotEmpty) {
              onSubmitGuess(Text);
              _controller.clear();
              _focus.requestFocus();
            }
          },
        ),
      ],
    );
  }
}
