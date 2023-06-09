import 'dart:async';

import 'package:cinepebble_social/app/features/posts/models/post.dart';
import 'package:cinepebble_social/utils/contants/firebase_collection_name.dart';
import 'package:cinepebble_social/utils/contants/firebase_field_name.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final allPostsProvider = StreamProvider.autoDispose<Iterable<Post>>((ref) {
  final controller = StreamController<Iterable<Post>>();

  final sub = FirebaseFirestore.instance
      .collection(FirebaseCollectionName.posts)
      .orderBy(
        FirebaseFieldName.createdAt,
        descending: true,
      )
      .snapshots()
      .listen((snapshot) {
    final posts = snapshot.docs.map(
      (doc) => Post(
        postId: doc.id,
        json: doc.data(),
      ),
    );
    controller.sink.add(posts);
  });

  ref.onDispose(() {
    sub.cancel();
    controller.close();
  });

  return controller.stream;
});
