import 'package:cinepebble_social/app/common/animations/empty_contents_animation_view.dart';
import 'package:cinepebble_social/app/common/animations/error_animation_view.dart';
import 'package:cinepebble_social/app/common/animations/loading_animation_view.dart';
import 'package:cinepebble_social/app/common/providers/user_id_provider.dart';
import 'package:cinepebble_social/app/features/comments/models/post_comment_request.dart';
import 'package:cinepebble_social/app/features/comments/repo/post_comments_provider.dart';
import 'package:cinepebble_social/app/features/comments/repo/send_comments_provider.dart';
import 'package:cinepebble_social/app/features/comments/views/widgets/comment_tile.dart';
import 'package:cinepebble_social/utils/contants/strings.dart';
import 'package:cinepebble_social/utils/extensions/dismiss_keyboard.dart';
import 'package:cinepebble_social/utils/typedefs/post_id.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class PostCommentsView extends HookConsumerWidget {
  const PostCommentsView({
    super.key,
    required this.postId,
  });

  final PostId postId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final commentController = useTextEditingController();

    final hasText = useState(false);

    final request = useState(
      RequestForPostAndComments(postId: postId),
    );

    final comments = ref.watch(
      postCommentsProvider(request.value),
    );

    useEffect(() {
      commentController.addListener(() {
        hasText.value = commentController.text.isNotEmpty;
      });
      return () {};
    }, [commentController]);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(Strings.comments),
        actions: [
          IconButton(
            onPressed: hasText.value
                ? () {
                    _submitCommentWithController(commentController, ref);
                  }
                : null,
            icon: const Icon(Icons.send),
          ),
        ],
      ),
      body: SafeArea(
        child: Flex(
          direction: Axis.vertical,
          children: [
            Expanded(
                flex: 4,
                child: comments.when(
                  data: (comments) {
                    if (comments.isEmpty) {
                      return const Center(
                        child: SingleChildScrollView(
                          child: EmptyContentsAnimationView(),
                        ),
                      );
                    }
                    return RefreshIndicator(
                      onRefresh: () {
                        ref.refresh(postCommentsProvider(request.value));
                        return Future.delayed(const Duration(seconds: 1));
                      },
                      child: ListView.builder(
                        padding: const EdgeInsets.all(8.0),
                        itemCount: comments.length,
                        itemBuilder: (context, index) {
                          final comment = comments.elementAt(index);
                          return CommentTile(comment: comment);
                        },
                      ),
                    );
                  },
                  error: (error, stackTrace) {
                    return const ErrorAnimationView();
                  },
                  loading: () => const LoadingAnimationView(),
                )),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: TextField(
                    textInputAction: TextInputAction.send,
                    controller: commentController,
                    onSubmitted: (comment) {
                      if (comment.isNotEmpty) {
                        _submitCommentWithController(commentController, ref);
                      }
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: Strings.writeYourCommentHere,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10.0)
          ],
        ),
      ),
    );
  }

  Future<void> _submitCommentWithController(
    TextEditingController controller,
    WidgetRef ref,
  ) async {
    final userId = ref.read(userIdProvider);
    if (userId == null) {
      return;
    }
    final isSent = await ref.read(sendCommentProvider.notifier).sendComment(
          fromUserId: userId,
          onPostId: postId,
          comment: controller.text,
        );

    if (isSent) {
      controller.clear();
      dismissKeyboard();
    }
  }
}
