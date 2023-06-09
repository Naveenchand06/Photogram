import 'package:cinepebble_social/app/common/animations/small_error_animation_view.dart';
import 'package:cinepebble_social/app/features/posts/models/post.dart';
import 'package:cinepebble_social/utils/app_colors.dart';
import 'package:flutter/material.dart';

class PostImageView extends StatelessWidget {
  final Post post;
  const PostImageView({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: post.aspectRatio,
      child: Image.network(
        post.fileUrl,
        fit: BoxFit.fill,
        errorBuilder: (context, error, stackTrace) {
          return const SmallErrorAnimationView();
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const Center(
            child: CircularProgressIndicator(
              color: AppColor.appColor,
            ),
          );
        },
      ),
    );
  }
}
