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

final currentUserProvider = FutureProvider((ref) async {
  return ref.watch(authControllerProvider.notifier).currentUser();
});

final currentUserDetailProvider = FutureProvider((ref) {
  final currentUserId = ref.watch(currentUserProvider).value!.$id;
  final userDetail = ref.watch(userDetailProvider(currentUserId));
  return userDetail.value;
});

final userDetailProvider = FutureProvider.family((ref, String uid) {
  return ref.watch(authControllerProvider.notifier).getUserData(uid);
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

  // isLoading

  Future<model.User?> currentUser() => _authAPI.currentUser();

  void signUp({
    required String email,
    required String password,
    required String userName,
    required BuildContext context,
  }) async {
    state = true;
    final res = await _authAPI.signUp(
      email: email,
      password: password,
      userName: userName,
    );
    state = false;
    res.fold(
      (l) => toastInfor(text: l.message),
      (r) async {
        UserModel userData = UserModel(
          email: email,
          name: userName,
          followers: [],
          following: [],
          profilePic: "",
          bannerPic: "",
          uid: r.$id,
          bio: "",
          isBlueCheck: false,
        );
        final res2 = await _userAPI.saveUserData(userData);
        res2.fold((l) => toastInfor(text: l.message), (r) {
          toastInfor(text: 'Create account success! Now please log in');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const SignInPage(),
            ),
          );
        });
      },
    );
  }

  void logIn({
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
    final documnet = await _userAPI.getUserData(uid);
    final updateUser = UserModel.fromMap(documnet.data);
    return updateUser;
  }
}
