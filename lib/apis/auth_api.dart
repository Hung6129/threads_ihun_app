import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as model;
import 'package:fpdart/fpdart.dart';
import 'package:riverpod/riverpod.dart';
import 'package:threads_ihun_app/core/providers.dart';
import 'package:threads_ihun_app/core/type_defs.dart';

import '../core/failure.dart';

final authAPIProvider = Provider((ref) {
  final account = ref.watch(appwriteAccountProvider);
  return AuthAPI(account: account);
});

abstract class IAuthAPI {
  FutureEither<model.User> signUp({
    required String email,
    required String password,
    required String name,
  });
  FutureEither<model.Session> signIn({
    required String email,
    required String password,
  });
  Future<model.User?> currentUserAccount();
  FutureEitherVoid logout();
}

class AuthAPI implements IAuthAPI {
  final Account _account;
  AuthAPI({required Account account}) : _account = account;

  @override
  Future<model.User?> currentUserAccount() async {
    try {
      final account = await _account.get();
      print('auth-api36: ${account.email}');
      return account;
    } on AppwriteException {
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  FutureEither<model.User> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final account = await _account.create(
        userId: ID.unique(),
        email: email,
        password: password,
        name: name,
      );
      return right(account);
    } on AppwriteException catch (e, stackTrace) {
      return left(
        Failure(e.message ?? 'Some unexpected error occurred', stackTrace),
      );
    } catch (e, stackTrace) {
      return left(
        Failure(e.toString(), stackTrace),
      );
    }
  }

  @override
  FutureEither<model.Session> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final session = await _account.createEmailSession(
        email: email,
        password: password,
      );
      return right(session);
    } on AppwriteException catch (e, stackTrace) {
      return left(
        Failure(e.message ?? 'Some unexpected error occurred', stackTrace),
      );
    } catch (e, stackTrace) {
      return left(
        Failure(e.toString(), stackTrace),
      );
    }
  }

  @override
  FutureEitherVoid logout() async {
    try {
      await _account.deleteSession(
        sessionId: 'current',
      );
      return right(null);
    } on AppwriteException catch (e, stackTrace) {
      return left(
        Failure(e.message ?? 'Some unexpected error occurred', stackTrace),
      );
    } catch (e, stackTrace) {
      return left(
        Failure(e.toString(), stackTrace),
      );
    }
  }
}
