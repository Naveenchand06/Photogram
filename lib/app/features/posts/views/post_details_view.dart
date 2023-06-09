import 'package:cinepebble_social/app/common/animations/error_animation_view.dart';
import 'package:cinepebble_social/app/common/animations/loading_animation_view.dart';
import 'package:cinepebble_social/app/common/animations/small_error_animation_view.dart';
import 'package:cinepebble_social/app/features/comments/models/post_comment_request.dart';
import 'package:cinepebble_social/app/features/comments/views/post_comments_view.dart';
import 'package:cinepebble_social/app/features/comments/views/widgets/compact_comment_column.dart';
import 'package:cinepebble_social/app/features/likes/views/like_button.dart';
import 'package:cinepebble_social/app/features/likes/views/likes_count_view.dart';
import 'package:cinepebble_social/app/features/posts/models/post.dart';
import 'package:cinepebble_social/app/features/posts/models/specific_post_with_comments_provider.dart';
import 'package:cinepebble_social/app/features/posts/repo/can_current_user_delete_post_provider.dart';
import 'package:cinepebble_social/app/features/posts/repo/delete_post_state_provider.dart';
import 'package:cinepebble_social/app/features/posts/views/post_image_view.dart';
import 'package:cinepebble_social/app/features/posts/widgets/post_date_view.dart';
import 'package:cinepebble_social/app/features/posts/widgets/post_displayname_and_message_view.dart';
import 'package:cinepebble_social/utils/app_colors.dart';
import 'package:cinepebble_social/utils/contants/strings.dart';
import 'package:cinepebble_social/utils/dialogs/alert_dialog_model.dart';
import 'package:cinepebble_social/utils/dialogs/delete_dialog.dart';
import 'package:cinepebble_social/utils/enums/date_sorting.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:share_plus/share_plus.dart';

class PostDetailsView extends ConsumerStatefulWidget {
  final Post post;
  const PostDetailsView({
    super.key,
    required this.post,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PostDetailsViewState();
}

class _PostDetailsViewState extends ConsumerState<PostDetailsView> {
  @override
  Widget build(BuildContext context) {
    final request = RequestForPostAndComments(
      postId: widget.post.postId,
      limit: 3,
      sortByCreatedAt: true,
      dateSorting: DateSorting.oldestOnTop,
    );

    // Get the post with comments
    final postWithComments =
        ref.watch(specificPostWithCommnetsProvider(request));

    // Can we dleete post
    final canDeletePost = ref.watch(
      cancurrentUserDeletePostProvider(
        widget.post,
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.postDetails),
        actions: [
          // Share button
          postWithComments.when(
            data: (postWithComments) {
              return IconButton(
                onPressed: () {
                  final url = postWithComments.post.fileUrl;
                  Share.share(url, subject: Strings.checkOutThisPost);
                },
                icon: const Icon(Icons.share),
              );
            },
            error: (error, stackTrace) {
              return const SmallErrorAnimationView();
            },
            loading: () => const Center(
              child: CircularProgressIndicator(
                color: AppColor.appColor,
              ),
            ),
          ),

          // Delete button
          if (canDeletePost.value ?? false)
            IconButton(
              onPressed: () async {
                final shouldDeletePost = await const DeleteDialog(
                        titleOfObjectToDelete: Strings.post)
                    .present(context)
                    .then(
                      (value) => value ?? false,
                    );
                if (shouldDeletePost) {
                  await ref
                      .read(deletePostProvider.notifier)
                      .deletePost(post: widget.post);
                  if (mounted) {
                    Navigator.of(context).pop();
                  }
                }
              },
              icon: const Icon(Icons.delete),
            )
        ],
      ),
      body: postWithComments.when(
        data: (postWithComments) {
          final postId = postWithComments.post.postId;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                PostImageView(post: postWithComments.post),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (postWithComments.post.allowsLikes)
                      LikeButton(postId: postId),
                    if (postWithComments.post.allowsComments)
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return PostCommentsView(postId: postId);
                              },
                            ),
                          );
                        },
                        icon: const Icon(Icons.mode_comment_outlined),
                      ),
                  ],
                ),
                // Post Detail and divider
                PostDisplayNameAndMessageView(post: postWithComments.post),
                PostDateView(dateTime: postWithComments.post.createdAt),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Divider(color: Colors.grey.shade400),
                ),
                CompactCommentColumn(comments: postWithComments.comments),
                // display like count
                if (postWithComments.post.allowsLikes)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        LikesCountView(postId: postId),
                      ],
                    ),
                  ),
                // add spacing
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          );
        },
        error: (error, stackTrace) => const ErrorAnimationView(),
        loading: () => const LoadingAnimationView(),
      ),
    );
  }
}
