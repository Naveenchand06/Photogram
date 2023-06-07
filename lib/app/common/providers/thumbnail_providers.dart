import 'package:cinepebble_social/app/features/posts/models/file_type.dart';
import 'package:cinepebble_social/app/features/posts/models/image_with_aspect_ratio.dart';
import 'package:cinepebble_social/app/features/posts/models/thumbnail_request.dart';
import 'package:cinepebble_social/utils/extensions/get_image_aspect_ratio.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final thumbnailProvider =
    FutureProvider.family.autoDispose<ImageWithAspectRatio, ThumbnailRequest>(
  (ref, ThumbnailRequest request) async {
    final Image image;
    switch (request.fileType) {
      case FileType.image:
        image = Image.file(
          request.file,
          fit: BoxFit.fitHeight,
        );
        break;
      default:
        image = Image.file(
          request.file,
          fit: BoxFit.fitHeight,
        );
        break;
      // case FileType.video:
      //   final thumb = await VideoThumbnail.thumbnailData(
      //       video: request.file.path,
      //       imageFormat: ImageFormat.JPEG,
      //       quality: 75);
      //   if (thumb == null) {
      //     throw Exception('Could not build thumbnail');
      //   }
      //   image = Image.memory(
      //     thumb,
      //     fit: BoxFit.fitHeight,
      //   );
      //   break;
    }
    final aspectRatio = await image.getAspectRatio();
    return ImageWithAspectRatio(image: image, aspectRatio: aspectRatio);
  },
);
