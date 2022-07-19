import 'package:flutter/material.dart';

import '../../constants/size.dart';

class FilmCard extends StatelessWidget {
  final String image;

  const FilmCard({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.screenWidth * 0.35,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Material(
            elevation: 15,
            borderRadius: BorderRadius.circular(15),
            child: Container(
              width: SizeConfig.screenWidth * 0.35,
              height: SizeConfig.screenHeight * 0.225,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: AssetImage(
                    image,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Text(
            'Amr Mahmoud Mohamed',
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleLarge!,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: const [
              Text('2hr 9 min'),
              Spacer(),
              Text('4.5'),
              Icon(
                Icons.star,
                color: Colors.amber,
              )
            ],
          )
        ],
      ),
    );
  }
}
