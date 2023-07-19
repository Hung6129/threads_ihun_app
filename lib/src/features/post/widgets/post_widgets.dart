import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/enums/post_type_enum.dart';
import '../controller/post_controller.dart';

class ListPostView extends ConsumerWidget {
  const ListPostView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getPostProvider).when(
          data: (posts) {
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final postModel = posts[index];
                  return Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          radius: 20.h,
                          backgroundImage: const NetworkImage(
                            'https://i.pinimg.com/originals/45/8c/ef/458cef766d53e9054ca952b4b87f2f85.jpg',
                          ),
                        ),
                        title: const Row(
                          children: [
                            Text(
                              'User Name',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Spacer(),
                            Text(
                              '3h',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(width: 10),
                            Icon(
                              Icons.more_horiz,
                              color: Colors.grey,
                              size: 15,
                            ),
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
                                        borderRadius:
                                            BorderRadius.circular(12.h),
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
                        padding:
                            EdgeInsets.only(right: 20.w, left: 70.w, top: 10.h),
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
                        padding:
                            EdgeInsets.only(right: 20.w, left: 70.w, top: 10.h),
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
                  );
                },
                childCount: posts.length,
              ),
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
