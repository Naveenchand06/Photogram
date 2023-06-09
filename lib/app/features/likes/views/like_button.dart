import 'package:cinepebble_social/app/common/animations/small_error_animation_view.dart';
import 'package:cinepebble_social/app/common/providers/user_id_provider.dart';
import 'package:cinepebble_social/app/features/likes/models/like_dislike_request.dart';
import 'package:cinepebble_social/app/features/likes/repo/has_liked_post_provider.dart';
import 'package:cinepebble_social/app/features/likes/repo/like_dislike_post_provider.dart';
import 'package:cinepebble_social/utils/app_colors.dart';
import 'package:cinepebble_social/utils/typedefs/post_id.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LikeButton extends ConsumerWidget {
  final PostId postId;
  const LikeButton({
    super.key,
    required this.postId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasLiked = ref.watch(hasLikedPostProvider(postId));
    return hasLiked.when(
      data: (hasLiked) {
        return IconButton(
          onPressed: () {
            final userId = ref.read(userIdProvider);
            if (userId == null) {
              return;
            }
            final likeRequest =
                LikeDislikeRequest(postId: postId, likedBy: userId);
            ref.read(likeDislikePostProvider(likeRequest));
          },
          icon: FaIcon(
            hasLiked ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
            color: hasLiked ? Colors.redAccent : null,
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
