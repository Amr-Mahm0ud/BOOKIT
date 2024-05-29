import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Button extends StatelessWidget {
  final String label;
  final void Function()? onPressed;
  final bool border;

  const Button({
    super.key,
    required this.label,
    required this.onPressed,
    this.border = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: border
          ? OutlinedButton.styleFrom(
              backgroundColor: Colors.transparent,
              elevation: 0,
              fixedSize: Size(Get.width, Get.height * 0.075),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: const BorderSide(
                    color: Colors.white,
                  )),
            )
          : ElevatedButton.styleFrom(
              elevation: 15,
              backgroundColor: Theme.of(context).colorScheme.primary,
              fixedSize: Size(Get.width, Get.height * 0.075),
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
