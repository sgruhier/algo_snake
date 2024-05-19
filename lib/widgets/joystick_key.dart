import 'package:flutter/material.dart';
import 'package:flutter_snake/models/tile_model.dart';

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
    // return a circle container
    return GestureDetector(
      onTap: () => onTap(direction),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey[300],
        ),
        child: Icon(getIcon()),
      ),
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
