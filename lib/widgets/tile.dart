import 'package:flutter/material.dart';
import 'package:flutter_snake/models/tile_model.dart';

class Tile extends StatelessWidget {
  const Tile({required this.tileType, this.child, super.key});
  final TileType tileType;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    switch (tileType) {
      case TileType.empty:
        return container(Colors.grey[400]!);
      case TileType.snakeBody:
        return container(Colors.green);
      case TileType.snakeHead:
        return container(Colors.green[200]!);
      case TileType.snakeTail:
        return container(Colors.green[900]!);
      case TileType.food:
        return container(Colors.red);
      default:
        return const SizedBox();
    }
  }

  Container container(Color color) {
    return Container(
        color: color,
        margin: const EdgeInsets.all(1),
        child: Center(
          child: child,
        ));
  }
}