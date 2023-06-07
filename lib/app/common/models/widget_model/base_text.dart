import 'package:cinepebble_social/app/common/models/widget_model/link_text.dart';
import 'package:flutter/material.dart';

@immutable
class BaseText {
  final String text;
  final TextStyle? style;

  // bool get isLinktext => this is LinkText;

  const BaseText({
    required this.text,
    this.style,
  });

  factory BaseText.plain({
    required String text,
    TextStyle? style = const TextStyle(color: Colors.black),
  }) =>
      BaseText(
        text: text,
        style: style,
      );

  factory BaseText.link({
    required String text,
    required VoidCallback onTapped,
    TextStyle? style = const TextStyle(
      color: Colors.blue,
      decoration: TextDecoration.underline,
    ),
  }) =>
      LinkText(
        text: text,
        onTapped: onTapped,
        style: style,
      );
}
