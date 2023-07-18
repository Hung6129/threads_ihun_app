import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:threads_ihun_app/features/authenticate/controllers/auth_controller.dart';

class ProfileView extends ConsumerWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: Center(
      child: TextButton(
        onPressed: () {
          ref.read(authControllerProvider.notifier).logout(context);
        },
        child: const Text('Logout'),
      ),
    ));
  }
}
