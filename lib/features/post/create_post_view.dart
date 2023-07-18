import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:threads_ihun_app/features/authenticate/controllers/auth_controller.dart';

class CreatePostView extends ConsumerStatefulWidget {
  const CreatePostView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreatePostViewState();
}

class _CreatePostViewState extends ConsumerState<CreatePostView> {
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
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage:
                                NetworkImage(currentUser.profilePic),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(currentUser.name),
                              SizedBox(width: 250.w, child: const TextField())
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ));
  }
}
