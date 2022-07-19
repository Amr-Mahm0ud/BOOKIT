import 'package:flutter/material.dart';

import '../../constants/size.dart';

class FilmTile extends StatelessWidget {
  final String image;

  const FilmTile({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final subtitleStyle = Theme.of(context)
        .textTheme
        .subtitle2!
        .copyWith(color: Theme.of(context).textTheme.headline4!.color);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Material(
            elevation: 10,
            borderRadius: BorderRadius.circular(15),
            child: Container(
              width: SizeConfig.screenWidth * 0.33,
              height: SizeConfig.screenWidth * 0.45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Spider-Man ay-goz2 b2a',
                style: Theme.of(context).textTheme.titleLarge,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Text('Director Name', style: subtitleStyle),
              Text('Comedy, Fantasy, Adventure', style: subtitleStyle),
              Text('2020, USA', style: subtitleStyle),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: const [
                  Text('4.5'),
                  Icon(Icons.star, color: Colors.amber),
                ],
              )
            ],
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
