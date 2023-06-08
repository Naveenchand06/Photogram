import 'package:cinepebble_social/app/common/components/post_thumbnail_view.dart';
import 'package:cinepebble_social/app/features/comments/views/post_comments_view.dart';
import 'package:cinepebble_social/app/features/posts/models/post.dart';
import 'package:flutter/material.dart';

class PostsGridView extends StatelessWidget {
  const PostsGridView({
    super.key,
    required this.posts,
  });

  final Iterable<Post> posts;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
      ),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts.elementAt(index);
        return PostThumbnailView(
          post: post,
          onTapped: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => PostCommentsView(postId: post.postId),
              ),
            );
          },
        );
      },
    );
  }
}
