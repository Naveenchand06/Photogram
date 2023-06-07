import 'package:cinepebble_social/app/common/models/widget_model/base_text.dart';
import 'package:flutter/foundation.dart' show immutable, VoidCallback;

@immutable
class LinkText extends BaseText {
  final VoidCallback onTapped;

  const LinkText({
    required super.text,
    required this.onTapped,
    super.style,
  });
}
