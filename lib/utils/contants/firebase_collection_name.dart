import 'package:flutter/foundation.dart' show immutable;

@immutable
class FirebaseCollectionName {
  static const profile = "profile";
  static const thumbnails = "thumbnails";
  static const comments = "comments";
  static const likes = "likes";
  static const posts = "posts";
  static const users = "users";
  static const usersProfile = "user_profiles";

  const FirebaseCollectionName._();
}
