import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_snake/providers/game_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Score extends ConsumerWidget {
  const Score({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var game = ref.watch(gameProvider);
    return Stack(
      children: [
        Container(
            padding: const EdgeInsets.only(left: 18, top: 4, bottom: 4, right: 8),
            margin: const EdgeInsets.only(left: 16, top: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(game.score.toString())),
        SvgPicture.asset('assets/tomato_stroke.svg'),
      ],
    );
  }
}
