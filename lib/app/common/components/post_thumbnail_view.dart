import 'package:cinepebble_social/app/features/posts/models/post.dart';
import 'package:flutter/material.dart';

class PostThumbnailView extends StatelessWidget {
  const PostThumbnailView({
    super.key,
    required this.post,
    required this.onTapped,
  });

  final Post post;
  final VoidCallback onTapped;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapped,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: Image.network(
          post.thumbnailUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
