import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_snake/models/tile_model.dart';
import 'package:flutter_snake/providers/game_provider.dart';
import 'package:flutter_snake/widgets/board.dart';
import 'package:flutter_snake/widgets/joystick.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  Timer? timer;

  @override
  Widget build(BuildContext context) {
    var padding = MediaQuery.paddingOf(context);
    var game = ref.watch(gameProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('AlgoSnake'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            GestureDetector(
              onPanUpdate: (details) => _handleSwipe(details, ref),
              child: const Board(),
            ),
            const Expanded(
              child: Center(
                child: Joystick(),
              ),
            ),
            if (!game.isPlaying)
              ElevatedButton(
                onPressed: () => _start(),
                child: Text(game.isGameOver ? 'Restart' : 'Start'),
              ),
            if (game.isPlaying)
              ElevatedButton(
                onPressed: () => _pauseRestart(),
                child: Text(game.isPaused ? 'Continue' : 'Pause'),
              ),
            if (game.isGameOver) const Text('Game Over'),
            SizedBox(
              height: padding.bottom,
            )
          ],
        ),
      ),
    );
  }

  void _start() {
    ref.read(gameProvider.notifier).start();
    if (timer != null) {
      timer!.cancel();
    }
    var duration = max(200, 600 - 10 * ref.read(gameProvider).snake.length);
    timer = Timer.periodic(Duration(milliseconds: duration), (timer) {
      ref.read(gameProvider.notifier).moveSnake();
    });
  }

  void _pauseRestart() {
    if (ref.read(gameProvider).isPaused) {
      timer = Timer.periodic(const Duration(milliseconds: 300), (timer) {
        ref.read(gameProvider.notifier).moveSnake();
      });
    } else {
      timer!.cancel();
    }
    ref.read(gameProvider.notifier).togglePause();
  }

  void _handleSwipe(DragUpdateDetails details, WidgetRef ref) {
    if (ref.read(gameProvider).isPaused) return;

    const sensibilty = 10;
    if (details.delta.dy > sensibilty) {
      ref.read(gameProvider.notifier).setSnakeDirection(Direction.down);
    }
    if (details.delta.dy < -sensibilty) {
      ref.read(gameProvider.notifier).setSnakeDirection(Direction.up);
    }
    if (details.delta.dx > sensibilty) {
      ref.read(gameProvider.notifier).setSnakeDirection(Direction.right);
    }
    if (details.delta.dx < -sensibilty) {
      ref.read(gameProvider.notifier).setSnakeDirection(Direction.left);
    }
  }
}
