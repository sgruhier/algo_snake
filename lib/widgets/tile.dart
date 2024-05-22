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
        return container(
            angle: pi / 2,
            child: SvgPicture.asset(
              'assets/snake_body.svg',
              width: double.infinity,
            ));
      case TileType.snakeBodyVertical:
        return container(
            child: SvgPicture.asset(
          'assets/snake_body.svg',
          width: double.infinity,
        ));
      case TileType.snakeBodyUpLeft:
        return container(
            angle: -pi / 2,
            child: SvgPicture.asset(
              'assets/snake_corner.svg',
              width: double.infinity,
            ));
      case TileType.snakeBodyUpRight:
        return container(
            angle: pi,
            child: SvgPicture.asset(
              'assets/snake_corner.svg',
              width: double.infinity,
            ));
      case TileType.snakeBodyDownLeft:
        return container(
            angle: 0,
            child: SvgPicture.asset(
              'assets/snake_corner.svg',
              width: double.infinity,
            ));
      case TileType.snakeBodyDownRight:
        return container(
            angle: pi / 2,
            child: SvgPicture.asset(
              'assets/snake_corner.svg',
              width: double.infinity,
            ));

      case TileType.snakeHeadLeft:
        return container(
            angle: pi / 2,
            child: SvgPicture.asset(
              'assets/snake_head.svg',
              width: double.infinity,
            ));
      case TileType.snakeHeadRight:
        return container(
            angle: -pi / 2,
            child: SvgPicture.asset(
              'assets/snake_head.svg',
              width: double.infinity,
            ));
      case TileType.snakeHeadUp:
        return container(
            angle: pi,
            child: SvgPicture.asset(
              'assets/snake_head.svg',
              width: double.infinity,
            ));
      case TileType.snakeHeadDown:
        return container(
            angle: 0,
            child: SvgPicture.asset(
              'assets/snake_head.svg',
              width: double.infinity,
            ));

      case TileType.snakeTailLeft:
        return container(
            angle: pi / 2,
            child: SvgPicture.asset(
              'assets/snake_tail.svg',
              width: double.infinity,
            ));
      case TileType.snakeTailRight:
        return container(
            angle: -pi / 2,
            child: SvgPicture.asset(
              'assets/snake_tail.svg',
              width: double.infinity,
            ));
      case TileType.snakeTailUp:
        return container(
            angle: pi,
            child: SvgPicture.asset(
              'assets/snake_tail.svg',
              width: double.infinity,
            ));
      case TileType.snakeTailDown:
        return container(
            child: SvgPicture.asset(
          'assets/snake_tail.svg',
          width: double.infinity,
        ));

      case TileType.food:
        return container(
            child: SvgPicture.asset(
          'assets/tomato.svg',
          width: double.infinity,
        ));
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
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        child: Center(
          child: Transform.rotate(
            angle: angle,
            child: child,
          ),
        ));
  }
}
