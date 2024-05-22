import 'package:flutter/material.dart';
import 'package:flutter_snake/models/tile_model.dart';
import 'package:flutter_snake/widgets/button.dart';

class JoystickKey extends StatelessWidget {
  const JoystickKey({
    required this.direction,
    required this.onTap,
    super.key,
  });
  final Direction direction;
  final Function(Direction) onTap;

  @override
  Widget build(BuildContext context) {
    return Button(
      onTap: () => onTap(direction),
      child: Icon(getIcon()),
    );
  }

  IconData getIcon() {
    switch (direction) {
      case Direction.up:
        return Icons.arrow_upward;
      case Direction.down:
        return Icons.arrow_downward;
      case Direction.left:
        return Icons.arrow_back;
      case Direction.right:
        return Icons.arrow_forward;
    }
  }
}
