import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:threads_ihun_app/apis/auth_api.dart';
import 'package:threads_ihun_app/apis/user_api.dart';

import 'package:appwrite/models.dart' as model;
import 'package:threads_ihun_app/config/widgets/flutter_toast.dart';
import 'package:threads_ihun_app/features/authenticate/views/sign_in_page.dart';
import 'package:threads_ihun_app/features/main_menu/main_menu_view.dart';
import 'package:threads_ihun_app/models/user_model.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(
    authAPI: ref.watch(authAPIProvider),
    userAPI: ref.watch(userAPIProvider),
  );
});

final currentUserDetailsProvider = FutureProvider((ref) {
  final currentUserId = ref.watch(currentUserAccountProvider).value!.$id;
  final userDetails = ref.watch(userDetailsProvider(currentUserId));
  print(currentUserId);
  print(userDetails.value.toString());
  return userDetails.value;
});

final userDetailsProvider = FutureProvider.family((ref, String uid) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.getUserData(uid);
});

final currentUserAccountProvider = FutureProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.currentUser();
});

class AuthController extends StateNotifier<bool> {
  final AuthAPI _authAPI;
  final UserAPI _userAPI;
  AuthController({
    required UserAPI userAPI,
    required AuthAPI authAPI,
  })  : _authAPI = authAPI,
        _userAPI = userAPI,
        super(false);

  Future<model.User?> currentUser() => _authAPI.currentUserAccount();

  void signUp({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true;
    final res = await _authAPI.signUp(
      email: email,
      password: password,
    );
    state = false;
    res.fold(
      (l) => toastInfor(text: l.message),
      (r) async {
        UserModel userModel = UserModel(
          email: email,
          name: email,
          followers: const [],
          following: const [],
          profilePic: '',
          bannerPic: '',
          uid: r.$id,
          bio: '',
          isBlueCheck: false,
        );
        final res2 = await _userAPI.saveUserData(userModel);
        res2.fold((l) => toastInfor(text: l.message), (r) {
          toastInfor(text: 'Account created successfully');
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => SignInPage(),
              ),
              (route) => false);
        });
      },
    );
  }

  void signIn({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true;
    final res = await _authAPI.signIn(
      email: email,
      password: password,
    );
    state = false;
    res.fold(
      (l) => toastInfor(text: l.message),
      (r) => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const MainMenuView(),
        ),
      ),
    );
  }

  Future<UserModel> getUserData(String uid) async {
    final document = await _userAPI.getUserData(uid);
    final updatedUser = UserModel.fromMap(document.data);
    return updatedUser;
  }
}
