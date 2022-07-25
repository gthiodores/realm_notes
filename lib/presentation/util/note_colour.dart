import 'package:flutter/material.dart';

enum NoteColour {
  red(Color(0xffffcccb)),
  blue(Color(0xffbbdefb)),
  amber(Color(0xffffecb3)),
  purple(Color(0xfffff1ff));

  final Color color;

  const NoteColour(this.color);
}
