import 'package:flutter/material.dart';

InputDecoration textDecoration = InputDecoration(
  hintStyle: TextStyle(
    color: Color(0xffC4C4C4),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.white,
      width: 0.5,
      style: BorderStyle.solid,
    ),
    borderRadius: BorderRadius.zero
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Color(0xff0BC6E3),
      width: 0.5,
      style: BorderStyle.solid,
    ),
    borderRadius: BorderRadius.zero
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Color(0xffED5121),
      width: 0.5,
      style: BorderStyle.solid,
    ),
    borderRadius: BorderRadius.zero
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Color(0xffED5121),
      width: 0.5,
      style: BorderStyle.solid,
    ),
    borderRadius: BorderRadius.zero
  ),
  fillColor: Colors.transparent,
);

TextStyle textStyle = TextStyle(
  color: Colors.white,
);

class MyTextFormField extends TextFormField {
  
}