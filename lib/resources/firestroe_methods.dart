import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_flutter/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

import '../models/post_model.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadPost({
    required String description,
    required Uint8List file,
    required String uid,
    required String username,
    required String profileImage,
  }) async {
    String res = "some error occured";

    try {
      String photoUrl =
          await StorageMethods().uploadImageToStorage("posts", file, true);

      String postId = const Uuid().v1();

      PostModel post = PostModel(
        description: description,
        datePublished: DateTime.now(),
        uid: uid,
        postUrl: photoUrl,
        postId: postId,
        username: username,
        profileImage: profileImage,
        likes: [],
      );
      _firestore.collection("posts").doc(postId).set(post.toJson());
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<void> likePost({
    required String postId,
    required String uid,
    required List likes,
  }) async {
    try {
      if (likes.contains(uid)) {
        await _firestore.collection("posts").doc(postId).update({
          "likes": FieldValue.arrayRemove([uid]),
        });
      } else {
        _firestore.collection("posts").doc(postId).update({
          "likes": FieldValue.arrayUnion([uid]),
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> postComment ({
    required String uid,
    required String postId,
    required String text,
    required String name,
    required String profileImage,
    // required List likes,
  }) async {
    String res = "some error occured";

    try {
      if(text.isNotEmpty){
        String commentId = const Uuid().v1();
        await
        _firestore.collection("posts").doc(postId).collection("comments").doc(commentId).set({
          "profileImage" : profileImage,
          "name" : name,
          "uid" : uid,
          "text" : text,
          "commentId" : commentId,
          "datePublished" : DateTime.now(),
        });
      }else {
        print("text is empty");
      }
    } catch (err) {
      res = err.toString();
    }
  }

}
