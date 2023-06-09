import 'package:cinepebble_social/utils/contants/profile_strings.dart';

import 'dart:collection' show MapView;

import 'package:flutter/foundation.dart' show immutable;

@immutable
class UserProfileModel extends MapView<String, dynamic> {
  final String uid;
  final String username;
  final String mobile;
  final String whatIdo;
  final String bio;
  final String twitter;
  final String linkedin;
  final String instagram;

  UserProfileModel({
    required this.uid,
    required this.username,
    required this.mobile,
    required this.whatIdo,
    required this.bio,
    required this.twitter,
    required this.linkedin,
    required this.instagram,
  }) : super(
          {
            ProfileKey.uid: uid,
            ProfileKey.username: username,
            ProfileKey.mobile: username,
            ProfileKey.whatIdo: whatIdo,
            ProfileKey.bio: bio,
            ProfileKey.twitter: twitter,
            ProfileKey.linkedIn: linkedin,
            ProfileKey.instagram: instagram,
          },
        );

  UserProfileModel.fromJson(
    Map<String, dynamic> json, {
    required String uid,
  }) : this(
          uid: uid,
          username: json[ProfileKey.username] ?? '',
          mobile: json[ProfileKey.mobile] ?? '',
          whatIdo: json[ProfileKey.whatIdo] ?? '',
          bio: json[ProfileKey.bio] ?? '',
          twitter: json[ProfileKey.twitter] ?? '',
          linkedin: json[ProfileKey.linkedIn] ?? '',
          instagram: json[ProfileKey.instagram] ?? '',
        );
}
