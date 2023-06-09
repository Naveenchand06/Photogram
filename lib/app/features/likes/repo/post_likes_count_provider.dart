import 'dart:async';

import 'package:cinepebble_social/utils/contants/firebase_collection_name.dart';
import 'package:cinepebble_social/utils/contants/firebase_field_name.dart';
import 'package:cinepebble_social/utils/typedefs/post_id.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final postLikesCountProvider = StreamProvider.family.autoDispose<int, PostId>(
  (ref, PostId postId) {
    final controller = StreamController<int>.broadcast();

    controller.onListen = () {
      controller.sink.add(0);
    };

    final sub = FirebaseFirestore.instance
        .collection(FirebaseCollectionName.likes)
        .where(FirebaseFieldName.postId, isEqualTo: postId)
        .snapshots()
        .listen((snapshot) {
      controller.sink.add(snapshot.docs.length);
    });

    ref.onDispose(() {
      sub.cancel();
      controller.close();
    });

    return controller.stream;
  },
);
