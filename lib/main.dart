import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'src/config/constants/theme_data.dart';
import 'src/config/views/error_views.dart';
import 'src/features/authenticate/controllers/auth_controller.dart';
import 'src/features/landing/landing_view.dart';
import 'src/features/main_menu/main_menu_view.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenUtilInit(
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeApp.light,
        darkTheme: ThemeApp.dark,
        home: ref.watch(currentUserAccountProvider).when(
              data: (data) {
                if (data != null) {
                  return const MainMenuView();
                }
                return const LandingView();
              },
              error: (error, stackTrace) => ErrorPage(error: error.toString()),
              loading: () => const Center(child: CircularProgressIndicator()),
            ),
      ),
    );
  }
}
