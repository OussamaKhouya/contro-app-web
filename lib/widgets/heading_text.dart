import 'package:flutter/material.dart';
import 'package:flutter_web/constants/style.dart';
import 'package:flutter_web/widgets/custom_text.dart';

class HeadingText extends StatelessWidget {
  final String text;

  const HeadingText({Key? key, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomText(text: text,color: dark, size: 18,weight: FontWeight.bold);
  }
}