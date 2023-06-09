import 'package:cinepebble_social/app/common/animations/small_error_animation_view.dart';
import 'package:cinepebble_social/app/common/components/rich_two_parts_text.dart';
import 'package:cinepebble_social/app/features/authentication/repo/user_info_model_provider.dart';
import 'package:cinepebble_social/app/features/comments/models/comment.dart';
import 'package:cinepebble_social/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CompactCommentTile extends ConsumerWidget {
  final Comment comment;
  const CompactCommentTile({
    super.key,
    required this.comment,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(userInfoModelProvider(comment.fromUserId));

    return userInfo.when(
      data: (userInfo) {
        return RichTwoPartsText(
          leftPart: userInfo.displayName,
          rightPart: comment.comment,
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
}
