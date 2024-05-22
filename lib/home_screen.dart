import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_snake/models/tile_model.dart';
import 'package:flutter_snake/providers/game_provider.dart';
import 'package:flutter_snake/widgets/board.dart';
import 'package:flutter_snake/widgets/button.dart';
import 'package:flutter_snake/widgets/joystick.dart';
import 'package:flutter_snake/widgets/score.dart';
import 'package:flutter_snake/widgets/timer.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  Timer? timer;
  final Color backgroundGameOverColor = const Color(0xFFf09878);

  @override
  Widget build(BuildContext context) {
    var game = ref.watch(gameProvider);
    if (game.isGameOver) {
      timer!.cancel();
    }
    return Scaffold(
      backgroundColor: game.isGameOver ? backgroundGameOverColor : null,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Score(),
            Text('AlgoSnake', style: GoogleFonts.jua(fontSize: 24)),
            const TimerWidget(),
          ],
        ),
        backgroundColor: game.isGameOver ? backgroundGameOverColor : null,
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        constraints: const BoxConstraints(maxWidth: 1000),
        child: Column(
          children: [
            GestureDetector(
              onPanUpdate: (details) => _handleSwipe(details, ref),
              child: const Board(),
            ),
            Expanded(
              child: Stack(
                children: [
                  const Center(
                    child: Joystick(),
                  ),
                  Positioned(
                    top: 16,
                    right: 16,
                    child: Button(
                      padding: const EdgeInsets.all(8.0),
                      radius: 10,
                      onTap: _playAction,
                      child: _playIcon(),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Icon _playIcon() {
    var game = ref.watch(gameProvider);
    if (game.isGameOver) {
      return const Icon(Icons.refresh);
    }
    if (game.isPlaying && !game.isPaused) {
      return const Icon(Icons.pause);
    }
    return const Icon(Icons.play_arrow_outlined);
  }

  void _playAction() {
    var game = ref.watch(gameProvider);
    if (game.isPlaying) {
      _pauseResume();
    } else {
      _start();
    }
  }

  void _start() {
    ref.read(gameProvider.notifier).start();
    _pauseResume();
  }

  void _pauseResume() {
    ref.read(gameProvider.notifier).togglePause();
    if (ref.read(gameProvider).isPaused) {
      var duration = max(200, 600 - 10 * ref.read(gameProvider).snake.length);
      timer = Timer.periodic(Duration(milliseconds: duration), (timer) {
        ref.read(gameProvider.notifier).moveSnake();
      });
    } else {
      timer!.cancel();
    }
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
