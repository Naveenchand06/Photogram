import 'package:cinepebble_social/app/features/comments/views/post_comments_view.dart';
import 'package:cinepebble_social/app/features/likes/views/like_button.dart';
import 'package:cinepebble_social/app/features/posts/models/post.dart';
import 'package:cinepebble_social/app/features/posts/views/post_details_view.dart';
import 'package:cinepebble_social/app/features/posts/widgets/post_displayname_and_message_view.dart';
import 'package:flutter/material.dart';

class PostsListView extends StatelessWidget {
  const PostsListView({
    super.key,
    required this.posts,
  });

  final Iterable<Post> posts;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts.elementAt(index);

        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => PostDetailsView(post: post),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 12.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Column(
                children: [
                  Image.network(
                    post.thumbnailUrl,
                    fit: BoxFit.cover,
                    height: 230.0,
                    width: double.infinity,
                  ),
                  Container(
                    padding: const EdgeInsets.all(2.0),
                    color: Colors.white70,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 4.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: PostDisplayNameAndMessageView(
                            post: post,
                            addPadding: false,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            if (post.allowsLikes)
                              LikeButton(postId: post.postId),
                            if (post.allowsComments)
                              IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return PostCommentsView(
                                            postId: post.postId);
                                      },
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.mode_comment_outlined),
                              ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
