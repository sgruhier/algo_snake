import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  bool isPaused = false;

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
            const Board(),
            const Expanded(
              child: Center(
                child: Joystick(),
              ),
            ),
            if (!game.isPlaying)
              ElevatedButton(
                onPressed: () => _start(ref),
                child: Text(game.isGameOver ? 'Restart' : 'Start'),
              ),
            if (game.isPlaying)
              ElevatedButton(
                onPressed: () => _pauseRestart(ref),
                child: Text(isPaused ? 'Continue' : 'Pause'),
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

  void _start(WidgetRef ref) {
    ref.read(gameProvider.notifier).start();
    if (timer != null) {
      timer!.cancel();
    }
    var duration = max(200, 600 - 10 * ref.read(gameProvider).snake.length);
    timer = Timer.periodic(Duration(milliseconds: duration), (timer) {
      ref.read(gameProvider.notifier).moveSnake();
    });
  }

  void _pauseRestart(WidgetRef ref) {
    if (isPaused) {
      timer = Timer.periodic(const Duration(milliseconds: 300), (timer) {
        ref.read(gameProvider.notifier).moveSnake();
      });
    } else {
      timer!.cancel();
    }
    setState(() => isPaused = !isPaused);
  }
}
