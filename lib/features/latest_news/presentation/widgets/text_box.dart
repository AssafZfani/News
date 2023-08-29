import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TextBoxWidget extends StatelessWidget {
  final String text;

  const TextBoxWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 3,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: TextField(
          textAlign: TextAlign.center,
          readOnly: true,
          enabled: false,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              border: const OutlineInputBorder(),
              hintText: toBeginningOfSentenceCase(text))),
    );
  }
}
