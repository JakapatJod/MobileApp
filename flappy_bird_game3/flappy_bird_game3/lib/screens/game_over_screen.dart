import 'package:flutter/material.dart';
import 'package:flappy_bird_game/game/assets.dart';
import 'package:flappy_bird_game/game/flappy_bird_game.dart';

class GameOverScreen extends StatelessWidget {
  final FlappyBirdGame game;

  const GameOverScreen({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) => Material(
    color: Colors.black38,
    child: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHighScore(),
          const SizedBox(height: 20),
          Image.asset(Assets.gameOver),
          const SizedBox(height: 20),
          _buildCurrentScore(),
          const SizedBox(height: 30),
          _buildTopScores(),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: _onRestart,
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            child: const Text(
              'Restart',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    ),
  );

  Widget _buildHighScore() {
    return Text(
      'HighScore: ${game.highScore}',
      style: const TextStyle(
        fontSize: 60,
        color: Colors.white,
        fontFamily: 'Game',
      ),
    );
  }

  Widget _buildCurrentScore() {
    return Text(
      'Your Score: ${game.bird.score}',
      style: const TextStyle(
        fontSize: 60,
        color: Colors.white,
        fontFamily: 'Game',
      ),
    );
  }

  Widget _buildTopScores() {
    return Center(
      child: Container(
        padding: EdgeInsets.all(30.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
            width: 4.0,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (int i = 0; i < game.topThreeScores.length; i++)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
                  '${i + 1}. ${game.topThreeScores[i]}',
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontFamily: 'Game',
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _onRestart() {
    game.bird.reset();
    game.overlays.remove('gameOver');
    game.resumeEngine();
  }
}
