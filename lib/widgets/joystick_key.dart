import 'package:flutter/material.dart';
import 'package:flutter_snake/models/tile_model.dart';

class JoystickKey extends StatefulWidget {
  const JoystickKey({
    required this.direction,
    required this.onTap,
    super.key,
  });
  final Direction direction;
  final Function(Direction) onTap;

  @override
  State<JoystickKey> createState() => _JoystickKeyState();
}

class _JoystickKeyState extends State<JoystickKey> {
  bool _isPressed = false;

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _isPressed = true;
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _isPressed = false;
    });
    widget.onTap(widget.direction);
  }

  void _onTapCancel() {
    setState(() {
      _isPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        transform: Matrix4.translationValues(0, _isPressed ? 2 : 0, 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: const Color(0xFFF0F5FF),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, _isPressed ? 2 : 4),
              blurRadius: 0,
            ),
          ],
        ),
        child: Center(
          child: Icon(getIcon()),
        ),
      ),
    );
  }

  IconData getIcon() {
    switch (widget.direction) {
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
