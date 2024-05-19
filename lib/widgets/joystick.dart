import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_snake/models/tile_model.dart';
import 'package:flutter_snake/providers/game_provider.dart';
import 'package:flutter_snake/widgets/joystick_key.dart';

class Joystick extends ConsumerWidget {
  const Joystick({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.sizeOf(context);
    return SizedBox(
      width: size.width / 2,
      child: GridView.count(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        crossAxisSpacing: 1,
        mainAxisSpacing: 2,
        crossAxisCount: 3,
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          empty(),
          JoystickKey(direction: Direction.up, onTap: (direction) => move(direction, ref)),
          empty(),
          JoystickKey(direction: Direction.left, onTap: (direction) => move(direction, ref)),
          empty(),
          JoystickKey(direction: Direction.right, onTap: (direction) => move(direction, ref)),
          empty(),
          JoystickKey(direction: Direction.down, onTap: (direction) => move(direction, ref)),
          empty(),
        ],
      ),
    );
  }

  Widget empty() {
    return const SizedBox(width: 0);
  }

  void move(Direction direction, WidgetRef ref) {
    ref.read(gameProvider.notifier).moveSnake(direction);
  }
}
