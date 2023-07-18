import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:threads_ihun_app/config/constants/text_styles.dart';
import 'package:threads_ihun_app/core/utils.dart';
import 'package:threads_ihun_app/features/authenticate/controllers/auth_controller.dart';

class CreatePostView extends ConsumerStatefulWidget {
  const CreatePostView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreatePostViewState();
}

class _CreatePostViewState extends ConsumerState<CreatePostView> {
  List<File> images = [];

  final TextEditingController _postTextEditingController =
      TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _postTextEditingController.dispose();
  }

  // void onPickImage() async {
  //   final images = await pickImages();
  //   if (images.isNotEmpty) {
  //     setState(() {
  //       this.images = images;
  //     });
  //   }
  // }
  void onPickImages() async {
    images = await pickImages();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(currentUserDetailsProvider).value;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Create Post'),
          leadingWidth: 70.w,
          leading: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          automaticallyImplyLeading: false,
        ),
        body: currentUser == null
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(currentUser.profilePic),
                        ),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              currentUser.name,
                              style: TextStyles.defaultStyle.bold
                                  .setTextSize(16.sp),
                            ),
                            SizedBox(
                              width: 250.w,
                              child: TextField(
                                controller: _postTextEditingController,
                                decoration: const InputDecoration(
                                  hintText: 'What\'s on your mind?',
                                  border: InputBorder.none,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (images.isNotEmpty)
                    CarouselSlider(
                      items: images.map(
                        (file) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(
                              horizontal: 5,
                            ),
                            child: Image.file(file),
                          );
                        },
                      ).toList(),
                      options: CarouselOptions(
                        height: 400,
                        enableInfiniteScroll: false,
                      ),
                    ),
                ],
              ),
        bottomNavigationBar: BottomAppBar(
          child: SizedBox(
            height: 50.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton.icon(
                  onPressed: onPickImages,
                  icon: const Icon(Icons.photo),
                  label: const Text('Photo'),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.location_on),
                  label: const Text('Location'),
                ),
              ],
            ),
          ),
        ));
  }
}
