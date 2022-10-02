import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String description;
  final String uid;
  final String postUrl;
  final String postId;
  final String username;
  final String profileImage;
  final DateTime datePublished;
  final likes;

  PostModel({
    required this.description,
    required this.datePublished,
    required this.uid,
    required this.postUrl,
    required this.postId,
    required this.username,
    required this.profileImage,
    required this.likes,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "description": description,
        "postUrl": postUrl,
        "postId": postId,
        "profileImage": profileImage,
        "datePublished": datePublished,
        "likes": likes,
      };

  static PostModel fromSnap(DocumentSnapshot<Map<String, dynamic>> snapShot) {
    var snapshot = snapShot.data();
    return PostModel(
      description: snapshot!["description"],
      uid: snapshot!["uid"],
      postUrl: snapshot!["postUrl"],
      username: snapshot!["username"],
      profileImage: snapshot!["profileImage"],
      datePublished: snapshot!["datePublished"],
      postId: snapshot!["postId"],
      likes: snapshot!["likes"],
    );
  }
}
