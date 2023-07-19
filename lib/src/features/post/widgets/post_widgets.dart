import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:threads_ihun_app/src/features/authenticate/controllers/auth_controller.dart';
import 'package:threads_ihun_app/src/models/post_model.dart';

import '../../../core/constant.dart';
import '../../../core/enums/post_type_enum.dart';
import '../controller/post_controller.dart';

import 'package:timeago/timeago.dart' as timeago;

class ListPostView extends ConsumerWidget {
  const ListPostView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getPostProvider).when(
          data: (posts) {
            return ref.watch(getLatestPostProvider).when(
                  data: (data) {
                    if (data.events.contains(
                      'databases.*.collections.${AppwriteConstants.postsCollectionId}.documents.*.create',
                    )) {
                      posts.insert(0, PostModel.fromMap(data.payload));
                    } else if (data.events.contains(
                      'databases.*.collections.${AppwriteConstants.postsCollectionId}.documents.*.update',
                    )) {
                      // get id of original tweet
                      final startingPoint =
                          data.events[0].lastIndexOf('documents.');
                      final endPoint = data.events[0].lastIndexOf('.update');
                      final postId = data.events[0]
                          .substring(startingPoint + 10, endPoint);

                      var post = posts
                          .where((element) => element.postId == postId)
                          .first;

                      final postIndex = posts.indexOf(post);
                      posts.removeWhere((element) => element.postId == postId);

                      post = PostModel.fromMap(data.payload);
                      posts.insert(postIndex, post);
                    }
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        childCount: posts.length,
                        (context, index) {
                          final postModel = posts[index];
                          return PostItemView(postModel);
                        },
                      ),
                    );
                  },
                  error: (error, stackTrace) => SliverToBoxAdapter(
                    child: Center(
                      child: Text(error.toString()),
                    ),
                  ),
                  loading: () {
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        childCount: posts.length,
                        (context, index) {
                          final postModel = posts[index];
                          return PostItemView(postModel);
                        },
                      ),
                    );
                  },
                );
          },
          loading: () => const SliverToBoxAdapter(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
          error: (error, stackTrace) => SliverToBoxAdapter(
            child: Center(
              child: Text(error.toString()),
            ),
          ),
        );
  }
}

class PostItemView extends ConsumerWidget {
  final PostModel postModel;
  const PostItemView(this.postModel, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userDetailsProvider(postModel.userId));
    return user.when(
        data: (data) => Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    radius: 20.h,
                    backgroundImage: NetworkImage(
                      data.profilePic,
                    ),
                  ),
                  title: Row(
                    children: [
                      Text(
                        data.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Text(
                        '${timeago.format(postModel.createdAt)}',
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(width: 5.w),
                      Icon(Icons.more_horiz, color: Colors.grey),
                    ],
                  ),
                  subtitle: Text(
                    postModel.postDescription,
                  ),
                ),
                if (postModel.postType == PostType.image)
                  Padding(
                    padding: EdgeInsets.only(right: 20.w, left: 30.w),
                    child: CarouselSlider(
                      options: CarouselOptions(
                        height: 280.h,
                        initialPage: 0,
                        enableInfiniteScroll: false,
                        onPageChanged: (index, reason) {},
                        scrollDirection: Axis.horizontal,
                      ),
                      items: postModel.imageLinks
                          .map(
                            (item) => Padding(
                              padding: EdgeInsets.only(
                                right: 10.w,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.h),
                                  image: DecorationImage(
                                    image: NetworkImage(item),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                Padding(
                  padding: EdgeInsets.only(right: 20.w, left: 70.w, top: 10.h),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.favorite_border,
                      ),
                      SizedBox(width: 20.w),
                      const Icon(
                        Icons.chat_bubble_rounded,
                      ),
                      SizedBox(width: 20.w),
                      const Icon(
                        Icons.cached_rounded,
                      ),
                      SizedBox(width: 20.w),
                      const Icon(
                        Icons.send_rounded,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 20.w, left: 70.w, top: 10.h),
                  child: Row(
                    children: [
                      Text(
                        '${postModel.commentIds.length} replies . ${postModel.likes.length} likes . ${postModel.reShareCount} shares',
                      ),
                    ],
                  ),
                ),
                const Divider(),
              ],
            ),
        error: (error, stackTrace) => const Text('Error'),
        loading: () => const CircularProgressIndicator());
  }
}
