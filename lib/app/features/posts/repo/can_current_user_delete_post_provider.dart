import 'package:cinepebble_social/app/common/providers/user_id_provider.dart';
import 'package:cinepebble_social/app/features/posts/models/post.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final cancurrentUserDeletePostProvider =
    StreamProvider.family.autoDispose<bool, Post>((ref, Post post) async* {
  final userId = ref.watch(userIdProvider);
  yield userId == post.userId;
});
