import 'package:flutter/foundation.dart';

import 'package:threads_ihun_app/src/core/enums/post_type_enum.dart';

@immutable
class PostModel {
  final String postId;
  final String userId;
  final String postDescription;
  final List<String> hastags;
  final String link;
  final List<String> imageLinks;
  final PostType postType;
  final DateTime createdAt;
  final List<String> likes;
  final List<String> commentIds;
  final int reShareCount;
  const PostModel({
    required this.postId,
    required this.userId,
    required this.postDescription,
    required this.hastags,
    required this.link,
    required this.imageLinks,
    required this.postType,
    required this.createdAt,
    required this.likes,
    required this.commentIds,
    required this.reShareCount,
  });

  PostModel copyWith({
    String? postId,
    String? userId,
    String? postDescription,
    List<String>? hastags,
    String? link,
    List<String>? imageLinks,
    PostType? postType,
    DateTime? createdAt,
    List<String>? likes,
    List<String>? commentIds,
    int? reShareCount,
  }) {
    return PostModel(
      postId: postId ?? this.postId,
      userId: userId ?? this.userId,
      postDescription: postDescription ?? this.postDescription,
      hastags: hastags ?? this.hastags,
      link: link ?? this.link,
      imageLinks: imageLinks ?? this.imageLinks,
      postType: postType ?? this.postType,
      createdAt: createdAt ?? this.createdAt,
      likes: likes ?? this.likes,
      commentIds: commentIds ?? this.commentIds,
      reShareCount: reShareCount ?? this.reShareCount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'postDescription': postDescription,
      'hastags': hastags,
      'link': link,
      'imageLinks': imageLinks,
      'postType': postType.type,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'likes': likes,
      'commentIds': commentIds,
      'reShareCount': reShareCount,
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      postId: map['\$postId'] as String,
      userId: map['userId'] as String,
      postDescription: map['postDescription'] as String,
      hastags: List<String>.from((map['hastags'] as List<String>)),
      link: map['link'] as String,
      imageLinks: List<String>.from((map['imageLinks'] as List<String>)),
      postType: (map['postType'] as String).toPostTypeEnum(),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      likes: List<String>.from((map['likes'] as List<String>)),
      commentIds: List<String>.from((map['commentIds'] as List<String>)),
      reShareCount: map['reShareCount'] as int,
    );
  }

  @override
  String toString() {
    return 'PostModel(id: $postId, userId: $userId, postDescription: $postDescription, hastags: $hastags, link: $link, imageLinks: $imageLinks, postType: $postType, createdAt: $createdAt, likes: $likes, commentIds: $commentIds, reShareCount: $reShareCount)';
  }

  @override
  bool operator ==(covariant PostModel other) {
    if (identical(this, other)) return true;

    return other.postId == postId &&
        other.userId == userId &&
        other.postDescription == postDescription &&
        listEquals(other.hastags, hastags) &&
        other.link == link &&
        listEquals(other.imageLinks, imageLinks) &&
        other.postType == postType &&
        other.createdAt == createdAt &&
        listEquals(other.likes, likes) &&
        listEquals(other.commentIds, commentIds) &&
        other.reShareCount == reShareCount;
  }

  @override
  int get hashCode {
    return postId.hashCode ^
        userId.hashCode ^
        postDescription.hashCode ^
        hastags.hashCode ^
        link.hashCode ^
        imageLinks.hashCode ^
        postType.hashCode ^
        createdAt.hashCode ^
        likes.hashCode ^
        commentIds.hashCode ^
        reShareCount.hashCode;
  }
}
