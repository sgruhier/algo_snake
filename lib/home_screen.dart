import 'package:flutter/material.dart';
import 'package:flutter_snake/widgets/Board.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Board(),
            Expanded(
              child: Container(
                color: Colors.grey[200], // Example: background color for the remaining space
                child: const Center(
                  child: Text('Remaining Space'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
