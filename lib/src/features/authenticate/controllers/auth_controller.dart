import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:appwrite/models.dart' as model;
import '../../../config/apis/auth_api.dart';
import '../../../config/apis/user_api.dart';
import '../../../config/widgets/flutter_toast.dart';
import '../../../models/user_model.dart';
import '../../main_menu/main_menu_view.dart';
import '../views/sign_in_page.dart';

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
  print('auth-controller24: $currentUserId');
  return userDetails.value;
});

final userDetailsProvider = FutureProvider.family((ref, String uid) {
  final authController = ref.watch(authControllerProvider.notifier);
  print('auth-controller30: $uid');
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
    required String userName,
    required BuildContext context,
  }) async {
    state = true;
    final res = await _authAPI.signUp(
      email: email,
      password: password,
      name: userName,
    );

    state = false;
    res.fold(
      (l) => toastInfor(text: l.message),
      (r) async {
        UserModel userModel = UserModel(
          email: email,
          name: userName,
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
                builder: (context) => const SignInPage(),
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
    final res = await _authAPI.signIn(email: email, password: password);
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

  void logout(BuildContext context) async {
    final res = await _authAPI.logout();
    res.fold((l) => null, (r) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const SignInPage()),
        (route) => false,
      );
    });
  }
}
