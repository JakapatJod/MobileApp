import 'dart:developer';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flappy_bird_game/components/background.dart';
import 'package:flappy_bird_game/components/bird.dart';
import 'package:flappy_bird_game/components/ground.dart';
import 'package:flappy_bird_game/components/pipe_group.dart';
import 'package:flappy_bird_game/game/assets.dart';
import 'package:flappy_bird_game/game/configuration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class FlappyBirdGame extends FlameGame with TapDetector, HasCollisionDetection {
  FlappyBirdGame();

  late Bird bird;
  Timer interval = Timer(Config.pipeInterval, repeat: true);
  bool isHit = false;
  late TextComponent score;
  late int currentScore;
  late int highScore;
  List<int> topThreeScores = [];
  bool _isBackgroundMusicPlaying = true;

  @override
  Future<void> onLoad() async {
    highScore = await loadHighScore();
    currentScore = 0;

    addAll([
      Background(),
      Ground(),
      bird = Bird(),
      score = buildScore(),
    ]);

    interval.onTick = () => add(PipeGroup());

    playBackgroundMusic();
  }

  Future<int> loadHighScore() async {
    // Load high score from storage (you can use shared_preferences, for example)
    // If no high score is stored, return 0.
    // Example using shared_preferences:
    // return (await SharedPreferences.getInstance()).getInt('highScore') ?? 0;
    return 0;
  }

  void playBackgroundMusic() {
    WidgetsFlutterBinding.ensureInitialized();
    if (_isBackgroundMusicPlaying) {
      FlameAudio.loopLongAudio(Assets.music_backgroud);
    }
  }

  void toggleBackgroundMusic() {
    WidgetsFlutterBinding.ensureInitialized();
    if (_isBackgroundMusicPlaying) {
      FlameAudio.bgm.pause();
    } else {
      FlameAudio.bgm.resume();
    }
    _isBackgroundMusicPlaying = !_isBackgroundMusicPlaying;
  }

  bool isBackgroundMusicPlaying() {
    return _isBackgroundMusicPlaying;
  }

  void saveHighScore() async {
    // Save high score to storage
    // Example using shared_preferences:
    // (await SharedPreferences.getInstance()).setInt('highScore', highScore);
  }

  TextComponent buildScore() {
    return TextComponent(
      position: Vector2(size.x / 2, size.y / 2 * 0.2),
      anchor: Anchor.center,
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 40,
          fontFamily: 'Game',
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  void onTap() {
    bird.fly();
  }

  

  @override
  void update(double dt) {
    super.update(dt);
    interval.update(dt);

    currentScore = bird.score;
    score.text = 'Score: $currentScore | High Score: $highScore';

    if (currentScore > highScore) {
      highScore = currentScore;
      saveHighScore();

      log('New High Score: $highScore');
    }

    // Update the top three scores
    updateTopThreeScores();
  }

  void updateTopThreeScores() {
    if (!topThreeScores.contains(currentScore)) {
      topThreeScores.add(currentScore);
      topThreeScores.sort((a, b) => b.compareTo(a));

      // Keep only the top three scores
      topThreeScores = topThreeScores.take(3).toList();
    }

    log('Top Three Scores: $topThreeScores');
  }
}
