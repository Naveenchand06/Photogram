import 'dart:collection' show MapView;
import 'package:cinepebble_social/utils/contants/profile_strings.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
class ProfilePayload extends MapView<String, dynamic> {
  ProfilePayload({
    required String username,
    required String mobile,
    required String whatIdo,
    required String bio,
    required String twitter,
    required String linkedin,
    required String instagram,
  }) : super(
          {
            ProfileKey.username: username,
            ProfileKey.mobile: username,
            ProfileKey.whatIdo: whatIdo,
            ProfileKey.bio: bio,
            ProfileKey.twitter: twitter,
            ProfileKey.linkedIn: linkedin,
            ProfileKey.instagram: instagram,
          },
        );
}
