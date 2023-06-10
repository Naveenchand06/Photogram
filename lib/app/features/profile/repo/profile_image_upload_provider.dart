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

final profileImageUploadProvider =
    StateNotifierProvider<ProfileImageUploadNotifier, bool>((ref) {
  return ProfileImageUploadNotifier();
});

class ProfileImageUploadNotifier extends StateNotifier<bool> {
  ProfileImageUploadNotifier() : super(false);

  set isLoading(bool value) => state = value;

  Future<bool> upload({
    required File file,
    required FileType fileType,
    required UserId userId,
  }) async {
    isLoading = true;
    late Uint8List imgUint8List;
    switch (fileType) {
      case FileType.image:
        final fileAsImage = img.decodeImage(file.readAsBytesSync());
        if (fileAsImage == null) {
          isLoading = false;
          throw Exception('Could not build thumbnail');
        }
        final profileImage =
            img.copyResize(fileAsImage, width: Constants.imageThumbnailWidth);
        final profileImageData = img.encodeJpg(profileImage);
        imgUint8List = Uint8List.fromList(profileImageData);
        break;
      default:
        break;
    }

    final fileName = const Uuid().v4();

    // create references to the profile image
    final profileFileRef = FirebaseStorage.instance
        .ref()
        .child(userId)
        .child(FirebaseCollectionName.profile)
        .child(fileName);

    try {
      // Upload Profile Image
      await profileFileRef.putData(imgUint8List);
      return true;
    } catch (_) {
      debugPrint('Error: Uploadin Image');
      return false;
    } finally {
      isLoading = false;
    }
  }
}
