import 'package:flutter/material.dart';

class CustomSelectableText extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final FontWeight weight;

  const CustomSelectableText({Key? key, required this.text, this.size = 16, this.color = Colors.black, this.weight = FontWeight.normal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SelectableText(text,
        style: TextStyle(
            fontSize: size,
            color: color,
            fontWeight: weight));
  }
}