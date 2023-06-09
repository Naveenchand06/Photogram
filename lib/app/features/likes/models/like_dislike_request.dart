import 'package:cinepebble_social/utils/typedefs/post_id.dart';
import 'package:cinepebble_social/utils/typedefs/user_id.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
class LikeDislikeRequest {
  final PostId postId;
  final UserId likedBy;
  const LikeDislikeRequest({
    required this.postId,
    required this.likedBy,
  });
}
