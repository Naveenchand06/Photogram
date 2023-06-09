import 'package:cinepebble_social/app/common/animations/empty_contents_animation_view.dart';
import 'package:cinepebble_social/app/common/animations/empty_contents_with_text_animation_view.dart';
import 'package:cinepebble_social/app/common/animations/error_animation_view.dart';
import 'package:cinepebble_social/app/common/animations/loading_animation_view.dart';
import 'package:cinepebble_social/app/features/posts/repo/user_posts_provider.dart';
import 'package:cinepebble_social/app/features/posts/views/posts_grid_view.dart';
import 'package:cinepebble_social/app/features/posts/views/posts_list_view.dart';
import 'package:cinepebble_social/utils/app_colors.dart';
import 'package:cinepebble_social/utils/contants/strings.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserPostsView extends ConsumerWidget {
  const UserPostsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(userPostsProvider);
    return SizedBox(
      width: double.infinity,
      height: 500.0,
      child: RefreshIndicator(
        onRefresh: () {
          ref.refresh(userPostsProvider);
          return Future.delayed(const Duration(seconds: 1));
        },
        child: posts.when(
          data: (posts) {
            if (posts.isEmpty) {
              return const EmptyContentsWithTextAnimationView(
                text: Strings.youHaveNoPosts,
              );
            } else {
              return SizedBox(
                child: PostsGridView(posts: posts),
              );
            }
          },
          error: (error, stackTrace) {
            return const ErrorAnimationView();
          },
          loading: () {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColor.appColor,
              ),
            );
          },
        ),
      ),
    );
  }
}
