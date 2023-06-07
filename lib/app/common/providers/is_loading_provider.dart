import 'package:cinepebble_social/app/features/authentication/repo/auth_state_notifier.dart';
import 'package:cinepebble_social/app/features/posts/repo/image_upload_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final isLoadingProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateProvider);
  final isUploadingImage = ref.watch(imageUploadProvider);

  return authState.isLoading || isUploadingImage;
});
