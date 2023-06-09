import 'package:cinepebble_social/app/features/authentication/models/user_info_payload.dart';
import 'package:cinepebble_social/app/features/profile/models/profile_payload.dart';
import 'package:cinepebble_social/utils/contants/firebase_collection_name.dart';
import 'package:cinepebble_social/utils/contants/firebase_field_name.dart';
import 'package:cinepebble_social/utils/contants/profile_strings.dart';
import 'package:cinepebble_social/utils/typedefs/user_id.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

@immutable
class UserInfoStorage {
  // Saving userInfo to firebase collection
  Future<bool> saveUserInfo({
    required UserId userId,
    required String displayName,
    required String? email,
  }) async {
    try {
      final userInfo = await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.users)
          .where(FirebaseFieldName.userId, isEqualTo: userId)
          .limit(1)
          .get();

      if (userInfo.docs.isNotEmpty) {
        await userInfo.docs.first.reference.update({
          FirebaseFieldName.displayName: displayName,
          FirebaseFieldName.email: email ?? '',
        });
        return true;
      }

      // We don't have that user info
      final payload = UserInfoPayload(
        userId: userId,
        displayName: displayName,
        email: email,
      );

      debugPrint('payload is -> $payload');

      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.users)
          .add(payload);
      await storeUserProfile(
          userId: userId, displayName: displayName, email: email);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> storeUserProfile({
    required UserId userId,
    required String displayName,
    required String? email,
  }) async {
    try {
      final userProfilePayload = ProfilePayload(
        uid: userId,
        username: displayName,
        mobile: '',
        whatIdo: '',
        bio: '',
        twitter: '',
        linkedin: '',
        instagram: '',
      );
      debugPrint(
          'The User Profile name is ===> ${userProfilePayload[ProfileKey.username]}');

      final userInfo = await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.usersProfile)
          .where(FirebaseFieldName.userId, isEqualTo: userId)
          .limit(1)
          .get();

      if (userInfo.docs.isNotEmpty) {
        await userInfo.docs.first.reference.update({
          ProfileKey.username: displayName,
          ProfileKey.mobile: '',
          ProfileKey.bio: '',
          ProfileKey.whatIdo: '',
          ProfileKey.twitter: '',
          ProfileKey.linkedIn: '',
          ProfileKey.instagram: '',
        });
        return true;
      }

      debugPrint('Profile payload is -> $userProfilePayload');

      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.usersProfile)
          .add(userProfilePayload);
      return true;
    } catch (e) {
      return false;
    }
  }
}
