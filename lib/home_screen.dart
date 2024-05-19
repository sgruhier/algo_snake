import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_snake/providers/game_provider.dart';
import 'package:flutter_snake/widgets/board.dart';
import 'package:flutter_snake/widgets/joystick.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var padding = MediaQuery.paddingOf(context);
    ref.watch(gameProvider);
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
            ElevatedButton(
              onPressed: () => _start(ref),
              child: const Text('Start'),
            ),
            SizedBox(
              height: padding.bottom,
            )
          ],
        ),
      ),
    );
  }

  void _start(WidgetRef ref) {
    ref.read(gameProvider.notifier).start(nbRows: 10, nbColumns: 10);
  }
}
