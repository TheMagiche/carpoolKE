import 'package:flutter/material.dart';

double formIconSize = 17.0;

var formTextInputDecoration = InputDecoration(
  // cont1entPadding: EdgeInsets.symmetric(vertical:1 ,horizontal: ),
  isDense: false,
  fillColor: Colors.white,
  filled: true,
  labelStyle: TextStyle(
    color: Colors.black,
    fontFamily: 'Oxygen',
    fontSize: 13.0,
  ),
  errorStyle: TextStyle(
    color: Colors.white,
  ),
  focusedBorder:
      new OutlineInputBorder(borderSide: new BorderSide(color: Colors.white)),
  enabledBorder:
      new OutlineInputBorder(borderSide: new BorderSide(color: Colors.white)),
  errorBorder:
      new OutlineInputBorder(borderSide: new BorderSide(color: Colors.white)),
  focusedErrorBorder:
      new OutlineInputBorder(borderSide: new BorderSide(color: Colors.white)),
);
