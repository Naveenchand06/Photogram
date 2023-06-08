import 'package:cinepebble_social/app/features/comments/models/comment_payload.dart';
import 'package:cinepebble_social/utils/contants/firebase_collection_name.dart';
import 'package:cinepebble_social/utils/typedefs/is_loading.dart';
import 'package:cinepebble_social/utils/typedefs/post_id.dart';
import 'package:cinepebble_social/utils/typedefs/user_id.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final sendCommentProvider =
    StateNotifierProvider<SendCommentNotifier, IsLoading>((ref) {
  return SendCommentNotifier();
});

class SendCommentNotifier extends StateNotifier<IsLoading> {
  SendCommentNotifier() : super(false);

  set isLoading(bool value) => state = value;

  Future<bool> sendComment({
    required UserId fromUserId,
    required PostId onPostId,
    required String comment,
  }) async {
    isLoading = true;

    final payload = CommentPayload(
      fromUserId: fromUserId,
      onPostId: onPostId,
      comment: comment,
    );

    try {
      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.comments)
          .add(payload);
      return true;
    } catch (e) {
      return false;
    } finally {
      isLoading = false;
    }
  }
}
