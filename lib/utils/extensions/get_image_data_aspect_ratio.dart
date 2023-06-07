import 'package:cinepebble_social/utils/extensions/get_image_aspect_ratio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

extension GetimageDataAspectratio on Uint8List {
  Future<double> getAspectratio() {
    final image = Image.memory(this);
    return image.getAspectRatio();
  }
}
