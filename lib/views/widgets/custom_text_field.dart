import 'package:flutter/material.dart';

import 'costants.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Title',
        enabledBorder: BuildBorder(),
        focusedBorder: BuildBorder(kPrimaryColor),
      ),
      cursorColor: kPrimaryColor,
    );
  }
}

OutlineInputBorder BuildBorder([Color]) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(18),
    borderSide: BorderSide(
      color: Color ?? Colors.white,
    ),
  );
}
