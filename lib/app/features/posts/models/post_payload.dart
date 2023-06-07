import 'dart:collection' show MapView;
import 'package:cinepebble_social/app/features/posts/models/file_type.dart';
import 'package:cinepebble_social/app/features/posts/models/post_setting.dart';
import 'package:cinepebble_social/utils/contants/post_key.dart';
import 'package:cinepebble_social/utils/typedefs/user_id.dart';
import 'package:cloud_firestore/cloud_firestore.dart' show FieldValue;
import 'package:flutter/foundation.dart' show immutable;

@immutable
class PostPayload extends MapView<String, dynamic> {
  PostPayload({
    required UserId userId,
    required String message,
    required String thumbnailUrl,
    required String fileUrl,
    required FileType fileType,
    required String fileName,
    required double aspectRatio,
    required String thumbnailStorageId,
    required String originalFileStorageId,
    required Map<PostSetting, bool> postSettings,
  }) : super(
          {
            PostKey.userId: userId,
            PostKey.message: message,
            PostKey.createdAt: FieldValue.serverTimestamp(),
            PostKey.thumbnailUrl: thumbnailUrl,
            PostKey.fileUrl: fileUrl,
            PostKey.fileType: fileType.name,
            PostKey.fileName: fileName,
            PostKey.aspectRatio: aspectRatio,
            PostKey.thumbnailStorageId: thumbnailStorageId,
            PostKey.originalFileStorageId: originalFileStorageId,
            PostKey.postSettings: {
              for (final postSetting in postSettings.entries)
                postSetting.key.storageKey: postSetting.value,
            },
          },
        );
}
