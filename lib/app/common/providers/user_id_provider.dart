import 'package:cinepebble_social/app/features/authentication/repo/auth_state_notifier.dart';
import 'package:cinepebble_social/utils/typedefs/user_id.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final userIdProvider = Provider<UserId?>((ref) {
  return ref.watch(authStateProvider).userId;
});
