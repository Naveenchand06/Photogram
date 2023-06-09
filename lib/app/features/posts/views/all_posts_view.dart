import 'package:cinepebble_social/app/common/animations/empty_contents_with_text_animation_view.dart';
import 'package:cinepebble_social/app/common/animations/error_animation_view.dart';
import 'package:cinepebble_social/app/common/animations/loading_animation_view.dart';
import 'package:cinepebble_social/app/features/posts/repo/all_posts_provider.dart';
import 'package:cinepebble_social/app/features/posts/views/posts_list_view.dart';
import 'package:cinepebble_social/utils/app_colors.dart';
import 'package:cinepebble_social/utils/contants/strings.dart';
import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

class AllPostsView extends ConsumerWidget {
  const AllPostsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(allPostsProvider);
    return RefreshIndicator(
      color: AppColor.appColor,
      onRefresh: () {
        return Future.delayed(
          const Duration(seconds: 2),
        );
      },
      child: posts.when(
        data: (posts) {
          if (posts.isEmpty) {
            return const EmptyContentsWithTextAnimationView(
              text: Strings.noPostsAvailable,
            );
          } else {
            return PostsListView(posts: posts);
          }
        },
        error: (error, stackTrace) {
          return const ErrorAnimationView();
        },
        loading: () => const LoadingAnimationView(),
      ),
    );
  }
}
