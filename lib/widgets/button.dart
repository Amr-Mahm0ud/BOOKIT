import 'package:flutter/material.dart';
import 'package:movie_app/constants/size.dart';

class Button extends StatelessWidget {
  final String label;
  final void Function() onPressed;

  const Button({Key? key, required this.label, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 15,
        fixedSize: Size(SizeConfig.screenWidth, SizeConfig.screenHeight * 0.07),
        shadowColor: Theme.of(context).primaryColor.withOpacity(0.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(color: Colors.white),
      ),
    );
  }
}
