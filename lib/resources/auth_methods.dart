import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_flutter/models/user_model.dart';
import 'package:instagram_flutter/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot<Map<String, dynamic>> snap =
        await _firestore.collection("users").doc(currentUser.uid).get();
    return UserModel.fromSnap(snap);
  }

  // sign up user
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "some error occured";
    try {
      if (email.isNotEmpty &&
          password.isNotEmpty &&
          username.isNotEmpty &&
          bio.isNotEmpty &&
          file != null) {
        // register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        // print(cred.user!.uid);

        String photoUrl = await StorageMethods()
            .uploadImageToStorage("profilePics", file, false);

        // add user to our database

        UserModel user = UserModel(
          email: email,
          uid: cred.user!.uid,
          photoUrl: photoUrl,
          username: username,
          bio: bio,
          followers: [],
          following: [],
        );

        await _firestore.collection("users").doc(cred.user!.uid).set(
              user.toJson(),
            );

        res = "success";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  //log in user
  // Future<UserCredential?>

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    // UserCredential? credential ;
    String res = "Some error occurred";
    try {
      // credential =
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      res = "success";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
    return res;
    //return credential;
  }

  Future<void> signOut()async{
    await _auth.signOut();
  }
}
