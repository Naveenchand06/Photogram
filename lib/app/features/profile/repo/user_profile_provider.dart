import 'dart:async';
import 'package:cinepebble_social/app/features/profile/models/user_profile_model.dart';
import 'package:cinepebble_social/utils/contants/firebase_collection_name.dart';
import 'package:cinepebble_social/utils/contants/firebase_field_name.dart';
import 'package:cinepebble_social/utils/typedefs/user_id.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final userProfileModelProvider = StreamProvider.family
    .autoDispose<UserProfileModel, UserId>((ref, UserId userId) {
  final controller = StreamController<UserProfileModel>();

  final sub = FirebaseFirestore.instance
      .collection(FirebaseCollectionName.usersProfile)
      .where(
        FirebaseFieldName.userId,
        isEqualTo: userId,
      )
      .limit(1)
      .snapshots()
      .listen((snapshot) {
    final doc = snapshot.docs.first;
    final json = doc.data();
    final userProfileModel = UserProfileModel.fromJson(
      json,
      uid: userId,
    );
    controller.add(userProfileModel);
  });

  ref.onDispose(() {
    sub.cancel();
    controller.close();
  });
  return controller.stream;
});
