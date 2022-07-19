import 'package:flutter/material.dart';

class Indicator extends StatelessWidget {
  final List images;
  final int index;

  const Indicator({Key? key, required this.images, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: images
          .map(
            (image) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(
                horizontal: 3,
                vertical: 10,
              ),
              width: images.indexOf(image) == index ? 30 : 10,
              height: 5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: images.indexOf(image) == index
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).primaryColor.withOpacity(0.3),
              ),
            ),
          )
          .toList(),
    );
  }
}
