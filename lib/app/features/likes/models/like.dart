import 'dart:collection' show MapView;
import 'package:cinepebble_social/utils/contants/firebase_field_name.dart';
import 'package:cinepebble_social/utils/typedefs/post_id.dart';
import 'package:cinepebble_social/utils/typedefs/user_id.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
class Like extends MapView<String, String> {
  Like({
    required PostId postId,
    required UserId likedBy,
    required DateTime date,
  }) : super(
          {
            FirebaseFieldName.postId: postId,
            FirebaseFieldName.userId: likedBy,
            FirebaseFieldName.date: date.toIso8601String(),
          },
        );
}
