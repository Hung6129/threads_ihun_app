import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../authenticate/controllers/auth_controller.dart';


class ProfileView extends ConsumerWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserDetailsProvider).value;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(currentUser!.profilePic),
          ),
          const SizedBox(height: 10),
          Text(currentUser.name),
          const SizedBox(height: 10),
          TextButton(
            onPressed: () {
              ref.read(authControllerProvider.notifier).logout(context);
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
