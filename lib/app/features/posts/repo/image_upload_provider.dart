import 'dart:developer';
import 'dart:io';

import 'package:cinepebble_social/app/features/posts/models/file_type.dart';
import 'package:cinepebble_social/app/features/posts/models/post_payload.dart';
import 'package:cinepebble_social/app/features/posts/models/post_setting.dart';
import 'package:cinepebble_social/utils/contants/constants.dart';
import 'package:cinepebble_social/utils/contants/firebase_collection_name.dart';
import 'package:cinepebble_social/utils/extensions/get_collection_name_on_filetype.dart';
import 'package:cinepebble_social/utils/extensions/get_image_data_aspect_ratio.dart';
import 'package:cinepebble_social/utils/typedefs/user_id.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as img;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

final imageUploadProvider =
    StateNotifierProvider<ImageUploadNotifier, bool>((ref) {
  return ImageUploadNotifier();
});

class ImageUploadNotifier extends StateNotifier<bool> {
  ImageUploadNotifier() : super(false);

  set isLoading(bool value) => state = value;

  Future<bool> upload(
      {required File file,
      required FileType fileType,
      required String message,
      required Map<PostSetting, bool> postSettings,
      required UserId userId}) async {
    log('Uploadin Image');
    isLoading = true;
    late Uint8List thumbnailUint8List;
    switch (fileType) {
      case FileType.image:
        final fileAsImage = img.decodeImage(file.readAsBytesSync());
        if (fileAsImage == null) {
          isLoading = false;
          throw Exception('Could not build thumbnail');
        }
        final thumbnail =
            img.copyResize(fileAsImage, width: Constants.imageThumbnailWidth);
        final thumbnailData = img.encodeJpg(thumbnail);
        thumbnailUint8List = Uint8List.fromList(thumbnailData);
        break;
      default:
        break;
      // case FileType.video:
      //   final thumb = await VideoThumbnail.thumbnailData(
      //     video: file.path,
      //     imageFormat: ImageFormat.JPEG,
      //     maxHeight: Constants.videoThumbnailMaxHeight,
      //     quality: Constants.videoThumbnailQuality,
      //   );
      //   if (thumb == null) {
      //     isLoading = false;
      //     throw const CouldNotBuildThumbnailException();
      //   }
      //   thumbnailUint8List = thumb;
      //   break;
    }

    // Calculate aspect ratio
    final thumbnailAspectRatio = await thumbnailUint8List.getAspectratio();
    // Calculate references
    final fileName = const Uuid().v4();

    // create references to the thumbnail and image itself
    final thumbnailRef = FirebaseStorage.instance
        .ref()
        .child(userId)
        .child(FirebaseCollectionName.thumbnails)
        .child(fileName);

    final originalFileRef = FirebaseStorage.instance
        .ref()
        .child(userId)
        .child(fileType.collectionName)
        .child(fileName);

    try {
      // Upload Thumbnail
      final thumbnailUploadtask =
          await thumbnailRef.putData(thumbnailUint8List);
      final thumbnailStorageId = thumbnailUploadtask.ref.name;
      // Upload Original File
      final originalUploadtask =
          await originalFileRef.putData(thumbnailUint8List);
      final originalStorageId = originalUploadtask.ref.name;

      // Upload the post itself
      final postPayload = PostPayload(
        userId: userId,
        message: message,
        thumbnailUrl: await thumbnailRef.getDownloadURL(),
        fileUrl: await originalFileRef.getDownloadURL(),
        fileType: fileType,
        fileName: fileName,
        aspectRatio: thumbnailAspectRatio,
        thumbnailStorageId: thumbnailStorageId,
        originalFileStorageId: originalStorageId,
        postSettings: postSettings,
      );
      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.posts)
          .add(postPayload);
      return true;
    } catch (_) {
      log('Error: Uploadin Image');

      return false;
    } finally {
      isLoading = false;
    }
  }
}
