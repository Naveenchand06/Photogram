import 'package:cinepebble_social/app/common/providers/user_id_provider.dart';
import 'package:cinepebble_social/app/features/profile/models/profile_payload.dart';
import 'package:cinepebble_social/utils/contants/firebase_collection_name.dart';
import 'package:cinepebble_social/utils/contants/firebase_field_name.dart';
import 'package:cinepebble_social/utils/contants/profile_strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final updateUserProfileProvider =
    FutureProvider.family.autoDispose<bool, ProfilePayload>((
  ref,
  ProfilePayload payload,
) async {
  final userId = ref.watch(userIdProvider);

  try {
    final userInfo = await FirebaseFirestore.instance
        .collection(FirebaseCollectionName.usersProfile)
        .where(FirebaseFieldName.userId, isEqualTo: userId)
        .limit(1)
        .get();

    if (userInfo.docs.isNotEmpty) {
      await userInfo.docs.first.reference.update({
        ProfileKey.username: payload[ProfileKey.username],
        ProfileKey.mobile: payload[ProfileKey.mobile],
        ProfileKey.bio: payload[ProfileKey.bio],
        ProfileKey.whatIdo: payload[ProfileKey.whatIdo],
        ProfileKey.twitter: payload[ProfileKey.twitter],
        ProfileKey.linkedIn: payload[ProfileKey.linkedIn],
        ProfileKey.instagram: payload[ProfileKey.instagram],
      });
      return true;
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
});
