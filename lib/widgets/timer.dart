import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_snake/providers/game_provider.dart';
import 'package:google_fonts/google_fonts.dart';

class TimerWidget extends ConsumerStatefulWidget {
  const TimerWidget({super.key});

  @override
  ConsumerState<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends ConsumerState<TimerWidget> {
  Timer? _timer;
  int _secondsElapsed = 0;

  @override
  void initState() {
    super.initState();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _secondsElapsed++;
      });
    });
  }

  void _pauseTimer() {
    _timer?.cancel();
  }

  String get _formattedTime {
    final minutes = _secondsElapsed ~/ 60;
    final seconds = _secondsElapsed % 60;
    return '${_twoDigits(minutes)}:${_twoDigits(seconds)}';
  }

  String _twoDigits(int n) => n.toString().padLeft(2, '0');

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(gameProvider, (previous, next) {
     if ((previous?.isPaused == false && next.isPaused) || next.isGameOver) {
        if (previous!= null && previous.isGameOver) {
          _secondsElapsed = 0;
        }
        _pauseTimer();
        setState(() { });
      } else if (previous?.isPaused == true && !next.isPaused) {
        _startTimer();
        setState(() { });
      }
    });
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        _formattedTime,
        style: GoogleFonts.azeretMono(fontSize: 14),
      ),
    );
  }
}
