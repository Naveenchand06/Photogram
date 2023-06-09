import 'package:cinepebble_social/app/common/animations/small_error_animation_view.dart';
import 'package:cinepebble_social/app/common/components/rich_two_parts_text.dart';
import 'package:cinepebble_social/app/features/authentication/repo/user_info_model_provider.dart';
import 'package:cinepebble_social/app/features/posts/models/post.dart';
import 'package:cinepebble_social/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PostDisplayNameAndMessageView extends ConsumerWidget {
  final Post post;
  final bool addPadding;
  const PostDisplayNameAndMessageView({
    super.key,
    required this.post,
    this.addPadding = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfoModel = ref.watch(userInfoModelProvider(post.userId));
    return userInfoModel.when(
      data: (userInfoModel) {
        return Padding(
          padding: EdgeInsets.all(addPadding ? 8.0 : 0.0),
          child: RichTwoPartsText(
            leftPart: userInfoModel.displayName,
            rightPart: post.message,
          ),
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
    );
  }
}
