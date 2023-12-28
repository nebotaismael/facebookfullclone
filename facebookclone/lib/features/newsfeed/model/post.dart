// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String postid;
  final String posttitle;
  final String postcontent;
  final List<Map<String, dynamic>> postmedia;
  final List postlike;
  final List<Map<String, dynamic>> postcoments;
  final String authorName;
  final String authorprofilepicture;
  final DateTime publishdate;
  final String authorid;
  final String category;
  Post({
    required this.category,
    required this.authorid,
    required this.postid,
    required this.posttitle,
    required this.postcontent,
    required this.postmedia,
    required this.postlike,
    required this.postcoments,
    required this.authorName,
    required this.authorprofilepicture,
    required this.publishdate,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'postid': postid,
      'posttitle': posttitle,
      'postcontent': postcontent,
      'postmedia': postmedia,
      'postlike': postlike,
      'authorName': authorName,
      'authorprofilepicture': authorprofilepicture,
      'publishdate': publishdate.millisecondsSinceEpoch,
      'authorid': authorid,
      'category': category
    };
  }

  static Post fromMap(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    var data = snapshot.data();
    List<Map<String, dynamic>> postmedia = [];

    if (data?['postmedia'] != null && data?['postmedia'] is List) {
      List<dynamic> meidafiles = data?['postmedia'];
      postmedia = meidafiles
          .map((dynamic mediafiles) => Map<String, dynamic>.from(mediafiles))
          .toList();
    }

    List<Map<String, dynamic>> postcomments = [];

    if (data?['postcoments'] != null && data?['postcoments'] is List) {
      List<dynamic> comments = data?['postcoments'];
      postmedia = comments
          .map((dynamic comments) => Map<String, dynamic>.from(comments))
          .toList();
    }

    return Post(
      category: data?['category'] ?? '',
      postid: data?['postid'] ?? '',
      posttitle: data?['posttitle'] ?? '',
      postcontent: data?['postcontent'] ?? '',
      postmedia: postmedia,
      postlike: (data?['postlike'] as List?) ?? [],
      postcoments: postcomments,
      authorName: data?['authorName'] ?? '',
      authorprofilepicture: data?['authorprofilepicture'] ?? '',
      publishdate: DateTime.fromMillisecondsSinceEpoch(data?['publishdate']),
      authorid: data?['authorid'] ?? '',
    );
  }
}
