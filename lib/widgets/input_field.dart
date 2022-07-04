import 'package:flutter/material.dart';
import 'package:movie_app/constants/size.dart';

class InputField extends StatelessWidget {
  final TextInputType keyType;
  final String? Function(String?) validator;
  final String? Function(String?) onSave;
  final String hint;

  const InputField({
    Key? key,
    required this.keyType,
    required this.validator,
    required this.onSave,
    required this.hint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(
        style: BorderStyle.none,
      ),
    );
    return Padding(
      padding: EdgeInsets.symmetric(vertical: SizeConfig.screenHeight * 0.01),
      child: TextFormField(
        textAlign: TextAlign.center,
        obscureText: keyType == TextInputType.visiblePassword ? true : false,
        autocorrect: true,
        keyboardType: keyType,
        validator: validator,
        onSaved: onSave,
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
          enabledBorder: border,
          disabledBorder: border,
          errorBorder: border,
          focusedErrorBorder: border,
          focusedBorder: border,
          filled: true,
          fillColor: Theme.of(context).cardColor,
          contentPadding: const EdgeInsets.symmetric(vertical: 20),
        ),
      ),
    );
  }
}
