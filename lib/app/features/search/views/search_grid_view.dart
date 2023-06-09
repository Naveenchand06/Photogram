import 'package:cinepebble_social/app/common/animations/data_not_found_animation_view.dart';
import 'package:cinepebble_social/app/common/animations/empty_contents_with_text_animation_view.dart';
import 'package:cinepebble_social/app/common/animations/error_animation_view.dart';
import 'package:cinepebble_social/app/features/search/repo/post_by_search_term_provider.dart';
import 'package:cinepebble_social/app/features/search/views/posts_sliver_grid_view.dart';
import 'package:cinepebble_social/utils/contants/strings.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchGridView extends ConsumerWidget {
  final String searchTerm;
  const SearchGridView({
    super.key,
    required this.searchTerm,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (searchTerm.isEmpty) {
      return const EmptyContentsWithTextAnimationView(
        text: Strings.enterYourSearchTerm,
      );
    }

    final posts = ref.watch(postsBySearchTermProvider(searchTerm));

    return posts.when(
      data: (posts) {
        if (posts.isEmpty) {
          return const DataNotFoundAnimationView();
        } else {
          return PostsSliverGridView(posts: posts);
        }
      },
      error: (error, stackTrace) {
        return const ErrorAnimationView();
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
