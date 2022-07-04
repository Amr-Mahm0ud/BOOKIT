import 'package:flutter/material.dart';
import 'dart:math';

class Logo extends StatelessWidget {
  final double size;

  const Logo({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.secondary,
                Theme.of(context).colorScheme.primary,
              ],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
          child: RotationTransition(
            turns: const AlwaysStoppedAnimation(45 / 360),
            child: Icon(
              Icons.local_movies_outlined,
              color: Colors.white,
              size: size,
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          'BOOKIT',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ],
    );
  }
}
