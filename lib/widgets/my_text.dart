// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  MyText({
    Key? key,
    required this.title,
    this.color,
    this.size,
    this.fontFamily,
    this.align,
    this.decoration,
    this.overflow,
    this.fontWeight,
    this.textScaleFactor,
    this.maxLines,
  }) : super(key: key);
  final String title;
  final Color? color;
  final double? size;
  final String? fontFamily;
  final TextAlign? align;
  final TextDecoration? decoration;
  final TextOverflow? overflow;
  final FontWeight? fontWeight;
  final double? textScaleFactor;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: align ?? TextAlign.start,
      textScaleFactor: textScaleFactor ?? 1.2,
      maxLines: maxLines,
      style: TextStyle(
          color: color ?? Colors.black,
          fontSize: size ?? 12,
          decoration: decoration ?? TextDecoration.none,
          fontWeight: fontWeight ??
              (
                  //DecorationUtils.lang == "ar"
                  //?
                  FontWeight.w500
              //: FontWeight.w200
              ),
          fontFamily: fontFamily ??
              (
                  // DecorationUtils.lang == "ar"
                  //?
                  'Montserrat')),
      overflow: overflow,
    );
  }
}
