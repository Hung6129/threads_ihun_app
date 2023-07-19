import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:threads_ihun_app/src/config/apis/post_api.dart';
import 'package:threads_ihun_app/src/config/apis/storage_api.dart';
import 'package:threads_ihun_app/src/config/widgets/flutter_toast.dart';
import 'package:threads_ihun_app/src/features/authenticate/controllers/auth_controller.dart';
import 'package:threads_ihun_app/src/models/post_model.dart';
import '../../../core/enums/post_type_enum.dart';

final postControllerProvider = StateNotifierProvider<PostController, bool>(
  (ref) {
    return PostController(
      ref: ref,
      postApi: ref.watch(postAPIProvider),
      storageAPI: ref.watch(storageAPIProvider),
    );
  },
);

final getPostProvider = FutureProvider((ref) async {
  return await ref.watch(postControllerProvider.notifier).getPosts();
});

class PostController extends StateNotifier<bool> {
  final PostApi _postApi;
  final StorageAPI _storageAPI;
  final Ref _ref;
  PostController({
    required Ref ref,
    required PostApi postApi,
    required StorageAPI storageAPI,
  })  : _ref = ref,
        _postApi = postApi,
        _storageAPI = storageAPI,
        super(false);

  void sharePost({
    required List<File> images,
    required String postDescription,
    required BuildContext context,
  }) {
    if (postDescription.isEmpty) {
      toastInfor(
        text: 'Please enter post description',
      );
      return;
    }
    if (images.isEmpty) {
      _shareTextPost(
        postDescription: postDescription,
        context: context,
      );
    } else {
      _shareImagePost(
        images: images,
        postDescription: postDescription,
        context: context,
      );
    }
  }

  void _shareTextPost({
    required String postDescription,
    required BuildContext context,
  }) async {
    state = true;
    final listHastag = _getHastagsFromPostDescription(postDescription);
    final link = _getLinkFromPostDescription(postDescription);
    final userId = _ref.read(currentUserDetailsProvider).value!.uid;
    final PostModel post = PostModel(
      postId: '',
      userId: userId,
      postDescription: postDescription,
      hastags: listHastag,
      link: link,
      imageLinks: const [],
      postType: PostType.text,
      createdAt: DateTime.now(),
      likes: const [],
      commentIds: const [],
      reShareCount: 0,
    );
    final res = await _postApi.sharePost(post);
    state = false;
    res.fold(
      (failure) {
        toastInfor(
          text: failure.message,
        );
      },
      (postDb) {
        toastInfor(
          text: 'Post shared successfully',
        );
        Navigator.of(context).pop();
      },
    );
  }

  void _shareImagePost({
    required List<File> images,
    required String postDescription,
    required BuildContext context,
  }) async {
    state = true;
    final listHastag = _getHastagsFromPostDescription(postDescription);
    final link = _getLinkFromPostDescription(postDescription);
    final userId = _ref.read(currentUserDetailsProvider).value!.uid;
    final imageLinks = await _storageAPI.uploadImage(images);
    final PostModel post = PostModel(
      postId: '',
      userId: userId,
      postDescription: postDescription,
      hastags: listHastag,
      link: link,
      imageLinks: imageLinks,
      postType: PostType.image,
      createdAt: DateTime.now(),
      likes: const [],
      commentIds: const [],
      reShareCount: 0,
    );
    final res = await _postApi.sharePost(post);
    state = false;
    res.fold(
      (failure) {
        toastInfor(
          text: failure.message,
        );
      },
      (postDb) {
        toastInfor(
          text: 'Post shared successfully',
        );
        Navigator.of(context).pop();
      },
    );
  }

  String _getLinkFromPostDescription(
    String linkFromPostDescription,
  ) {
    final link = linkFromPostDescription.split(' ').firstWhere(
          (element) => element.contains('http') || element.contains('www'),
          orElse: () => '',
        );
    return link;
  }

  List<String> _getHastagsFromPostDescription(
    String postDescription,
  ) {
    final hastags = postDescription.split(' ').where(
          (element) => element.startsWith('#'),
        );
    return hastags.toList();
  }

  Future<List<PostModel>> getPosts() async {
    final posts = await _postApi.getPosts();
    return posts.map((post) => PostModel.fromMap(post.data)).toList();
  }
}
