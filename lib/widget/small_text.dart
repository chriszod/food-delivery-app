import 'package:flutter/material.dart';

import '../utils/dimensions.dart';

class SmallText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  double height;
  TextOverflow overflow;

  SmallText(
      {Key? key,
      this.color = const Color(0xFFccc7c5),
      required this.text,
      this.size = 0,
      this.overflow = TextOverflow.ellipsis,
      this.height = 1.2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: overflow,
      style: TextStyle(
          color: color,
          fontFamily: 'Roboto',
          fontSize: size == 0 ? Dimensions.calc(12) : size,
          height: height,
          fontWeight: FontWeight.w400),
    );
  }
}
