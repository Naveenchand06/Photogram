import 'package:cinepebble_social/app/common/components/post_thumbnail_view.dart';
import 'package:cinepebble_social/app/features/posts/models/post.dart';
import 'package:cinepebble_social/app/features/posts/views/post_details_view.dart';
import 'package:flutter/material.dart';

class PostsSliverGridView extends StatelessWidget {
  final Iterable<Post> posts;

  const PostsSliverGridView({
    super.key,
    required this.posts,
  });

  @override
  Widget build(BuildContext context) {
    double sw = MediaQuery.of(context).size.width;
    double sh = MediaQuery.of(context).size.width;

    return SizedBox(
      width: sw * 90 / 100,
      height: sh * 85 / 100,
      child: GridView.builder(
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
                  builder: (context) => PostDetailsView(post: post),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
