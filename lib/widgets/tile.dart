import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_snake/models/tile_model.dart';
import 'package:flutter_svg/svg.dart';

const tileBg = Color(0xFF67C1F3);

class Tile extends StatelessWidget {
  const Tile({
    required this.tileType,
    this.color,
    this.child,
    super.key,
  });
  final TileType tileType;
  final Color? color;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    switch (tileType) {
      case TileType.empty:
        return container();

      case TileType.snakeBodyHorizontal:
        return container(angle: pi / 2, child: SvgPicture.asset('assets/snake_body.svg'));
      case TileType.snakeBodyVertical:
        return container(child: SvgPicture.asset('assets/snake_body.svg'));
      case TileType.snakeBodyUpLeft:
        return container(angle: -pi / 2, child: SvgPicture.asset('assets/snake_corner.svg'));
      case TileType.snakeBodyUpRight:
        return container(angle: pi, child: SvgPicture.asset('assets/snake_corner.svg'));
      case TileType.snakeBodyDownLeft:
        return container(angle: 0, child: SvgPicture.asset('assets/snake_corner.svg'));
      case TileType.snakeBodyDownRight:
        return container(angle: pi / 2, child: SvgPicture.asset('assets/snake_corner.svg'));

      case TileType.snakeHeadLeft:
        return container(angle: pi / 2, child: SvgPicture.asset('assets/snake_head.svg'));
      case TileType.snakeHeadRight:
        return container(angle: -pi / 2, child: SvgPicture.asset('assets/snake_head.svg'));
      case TileType.snakeHeadUp:
        return container(angle: pi, child: SvgPicture.asset('assets/snake_head.svg'));
      case TileType.snakeHeadDown:
        return container(angle: 0, child: SvgPicture.asset('assets/snake_head.svg'));

      case TileType.snakeTailLeft:
        return container(angle: pi / 2, child: SvgPicture.asset('assets/snake_tail.svg'));
      case TileType.snakeTailRight:
        return container(angle: -pi / 2, child: SvgPicture.asset('assets/snake_tail.svg'));
      case TileType.snakeTailUp:
        return container(angle: pi, child: SvgPicture.asset('assets/snake_tail.svg'));
      case TileType.snakeTailDown:
        return container(child: SvgPicture.asset('assets/snake_tail.svg'));

      case TileType.food:
        return container(child: SvgPicture.asset('assets/tomato.svg'));
      default:
        return const SizedBox();
    }
  }

  Container container({Widget? child, double angle = 0}) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: color ?? tileBg,
        ),
        margin: const EdgeInsets.all(0),
        child: Center(
          child: Transform.rotate(
            angle: angle,
            child: child,
          ),
        ));
  }
}
