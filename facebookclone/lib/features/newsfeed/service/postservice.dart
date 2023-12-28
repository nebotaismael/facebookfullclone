// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebookclone/features/newsfeed/model/post.dart';
import 'package:facebookclone/features/utils/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class PostFirestorservice {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadposttofirebase(
      final String category,
      BuildContext context,
      String posttitle,
      String postcontent,
      String uid,
      String userName,
      String userprofilepicture,
      List<Map<String, dynamic>> filesDatalist) async {
    String res = 'an error occured';

    try {
      String postID = const Uuid().v1();

      Post post = Post(
        category: category,
        postid: postID,
        posttitle: posttitle,
        postcontent: postcontent,
        postmedia: filesDatalist,
        postlike: [],
        postcoments: [],
        authorName: userName,
        authorprofilepicture: userprofilepicture,
        publishdate: DateTime.now(),
        authorid: FirebaseAuth.instance.currentUser!.uid,
      );

      await _firestore.collection('posts').doc(postID).set(post.toMap());
      res = 'success';
      showsnackBar(context, 'posted');
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<void> likepost(BuildContext context, Post post) async {
    // ignore: unused_local_variable
    String res = 'an error occurred';
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      if (post.postlike.contains(uid)) {
        // Remove user from likes
        await _firestore.collection('posts').doc(post.postid).update({
          'postlike': FieldValue.arrayRemove([uid])
        });
      } else {
        // Add user to likes
        await _firestore.collection('posts').doc(post.postid).update({
          'postlike': FieldValue.arrayUnion([uid])
        });
      }

      // Show snackbar
      // Showsnackbar(context, res);
    } catch (e) {
      res = e.toString();
    }
  }

  Future<String> deletePost(String postId, BuildContext context) async {
    String res = "Some error occurred";
    try {
      // Retrieve the post data before deleting it
      DocumentSnapshot postSnapshot =
          await _firestore.collection('posts').doc(postId).get();
      Map<String, dynamic> postData =
          postSnapshot.data() as Map<String, dynamic>;

      // Move the post to the "archived_posts" collection instead of deleting it
      await _firestore.collection('archived_posts').doc(postId).set(postData);

      // Delete the post from the original collection
      await _firestore.collection('posts').doc(postId).delete();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          action: SnackBarAction(
              label: 'undo',
              onPressed: () {
                restoredeletedpost(postId, context);
              }),
          content: const Text('Successfully deleted')));

      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> restoredeletedpost(String postid, BuildContext context) async {
    String res = 'some error ocoured';
    try {
      DocumentSnapshot archievedpostsnapshot =
          await _firestore.collection('archived_posts').doc(postid).get();
      Map<String, dynamic> achievepostdata =
          archievedpostsnapshot.data() as Map<String, dynamic>;
      await _firestore.collection('archived_posts').doc(postid).delete();
      await _firestore.collection('posts').doc(postid).set(achievepostdata);

      res = 'success';
      showsnackBar(context, 'succesfully restored');
    } catch (e) {
      res = e.toString();
      // res = print(e);
    }
    return res;
  }

  Future<Post> postInfo(String postid) async {
    try {
      final snapshot = await _firestore.collection('posts').doc(postid).get();
      if (snapshot.exists) {
        return Post.fromMap(snapshot);
      } else {
        // Handle the case when the post doesn't exist
        throw Exception('Post not found');
      }
    } catch (e) {
      // Handle the error appropriately
      rethrow;
    }
  }

  Stream<List<Post>> getPostsStream(String postcategory) {
    return _firestore
        .collection('posts')
        .orderBy('publishdate', descending: true)
        .where('category', isEqualTo: postcategory)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((DocumentSnapshot<Map<String, dynamic>> document) =>
              Post.fromMap(document))
          .toList();
    });
  }

  Stream<List<Post>> getAllpoststream() {
    return _firestore
        .collection('posts')
        .orderBy('publishdate', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((DocumentSnapshot<Map<String, dynamic>> document) =>
              Post.fromMap(document))
          .toList();
    });
  }

  Stream<List<Post>> getSinglePostsStream(
    String selction,
    String destination,
  ) {
    return _firestore
        .collection('posts')
        .where(selction, isEqualTo: destination)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((DocumentSnapshot<Map<String, dynamic>> document) =>
              Post.fromMap(document))
          .toList();
    });
  }
}
