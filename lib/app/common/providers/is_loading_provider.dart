import 'package:cinepebble_social/app/features/authentication/repo/auth_state_notifier.dart';
import 'package:cinepebble_social/app/features/comments/repo/delete_comment_provider.dart';
import 'package:cinepebble_social/app/features/comments/repo/send_comments_provider.dart';
import 'package:cinepebble_social/app/features/posts/repo/delete_post_state_provider.dart';
import 'package:cinepebble_social/app/features/posts/repo/image_upload_provider.dart';
import 'package:cinepebble_social/app/features/profile/repo/profile_image_upload_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final isLoadingProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateProvider);
  final isUploadingImage = ref.watch(imageUploadProvider);
  final isSendingComment = ref.watch(sendCommentProvider);
  final isDeletingComment = ref.watch(deleteCommentProvider);
  final isDeletingPost = ref.watch(deletePostProvider);
  final isProfileUploading = ref.watch(profileImageUploadProvider);

  return authState.isLoading ||
      isUploadingImage ||
      isSendingComment ||
      isDeletingComment ||
      isDeletingPost ||
      isProfileUploading;
});
