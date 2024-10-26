import 'package:flutter/material.dart';

import 'custom_text_field.dart';

class AddNoteButtomSheet extends StatelessWidget {
  const AddNoteButtomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          CustomTextField(
            hintText: 'Title',
          ),
          SizedBox(
            height: 18,
          ),
          CustomTextField(
            hintText: 'Content',
            maxLines: 5,
          )
        ],
      ),
    );
  }
}
