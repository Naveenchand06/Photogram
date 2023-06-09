import 'package:cinepebble_social/app/common/animations/small_error_animation_view.dart';
import 'package:cinepebble_social/app/common/providers/user_id_provider.dart';
import 'package:cinepebble_social/app/features/authentication/repo/user_info_model_provider.dart';
import 'package:cinepebble_social/app/features/comments/models/comment.dart';
import 'package:cinepebble_social/app/features/comments/repo/delete_comment_provider.dart';
import 'package:cinepebble_social/utils/app_colors.dart';
import 'package:cinepebble_social/utils/contants/strings.dart';
import 'package:cinepebble_social/utils/dialogs/alert_dialog_model.dart';
import 'package:cinepebble_social/utils/dialogs/delete_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CommentTile extends ConsumerWidget {
  final Comment comment;
  const CommentTile({
    super.key,
    required this.comment,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(userInfoModelProvider(comment.fromUserId));
    return userInfo.when(
      data: (userInfo) {
        final currentUserId = ref.read(userIdProvider);
        return ListTile(
          title: Text(userInfo.displayName),
          subtitle: Text(comment.comment),
          trailing: currentUserId == comment.fromUserId
              ? IconButton(
                  onPressed: () async {
                    final shouldDelete = await displayDeleteDialog(context);
                    if (shouldDelete) {
                      await ref
                          .read(deleteCommentProvider.notifier)
                          .deleteComment(commentId: comment.id);
                    }
                  },
                  icon: const Icon(Icons.delete),
                )
              : null,
        );
      },
      error: (error, stackTrace) => const SmallErrorAnimationView(),
      loading: () => const Center(
        child: CircularProgressIndicator(
          color: AppColor.appColor,
        ),
      ),
    );
  }

  Future<bool> displayDeleteDialog(BuildContext context) {
    return const DeleteDialog(titleOfObjectToDelete: Strings.delete)
        .present(context)
        .then(
          (value) => value ?? false,
        );
  }
}
