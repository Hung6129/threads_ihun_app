import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:threads_ihun_app/features/main_menu/main_menu_view.dart';

import 'config/views/error_views.dart';
import 'features/authenticate/controllers/auth_controller.dart';
import 'features/landing/landing_view.dart';

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
        theme: ThemeData(
          colorSchemeSeed: Colors.white,
          useMaterial3: true,
          brightness: Brightness.light,
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.black,
          ),
        ),
        darkTheme: ThemeData(
          colorSchemeSeed: Colors.black,
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white,
          ),
          useMaterial3: true,
          brightness: Brightness.dark,
        ),
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
