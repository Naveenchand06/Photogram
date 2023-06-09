import 'package:flutter/foundation.dart' show immutable;

@immutable
class ProfileStrings {
  static const username = "Username";
  static const usernameHint = "Username";

  static const whatIdo = "What I do";
  static const whatIdoHint = "Write about what you do";

  static const bio = "Bio";
  static const bioHint = "Bio";

  static const phone = "Mobile";
  static const phoneHint = "Enter mobile number ";

  static const enterTheLink = "Enter the link";

  static const linkedin = "LinkedIn";
  static const twitter = "Twitter";
  static const insta = "Instagram";

  const ProfileStrings._();
}

@immutable
class ProfileKey {
  static const uid = "uid";
  static const username = "username";
  static const mobile = "mobile";
  static const whatIdo = "what_i_do";
  static const bio = "bio";
  static const twitter = "twitter";
  static const linkedIn = "linkedin";
  static const instagram = "instagram";

  const ProfileKey._();
}
