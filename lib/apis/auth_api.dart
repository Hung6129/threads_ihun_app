import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as model;
import 'package:fpdart/fpdart.dart';
import 'package:riverpod/riverpod.dart';
import 'package:threads_ihun_app/core/providers.dart';
import 'package:threads_ihun_app/core/type_defs.dart';

import '../core/failure.dart';

final authAPIProvider = Provider((ref) {
  return AuthAPI(account: ref.watch(appwriteAccountProvider));
});

abstract class IAuthAPI {
  FutureEither<model.User> signUp({
    required String email,
    required String password,
    required String userName,
  });

  FutureEither<model.Session> signIn({
    required String email,
    required String password,
  });

  Future<model.User?> currentUser();
}

class AuthAPI implements IAuthAPI {
  final Account _account;

  AuthAPI({required Account account}) : _account = account;
  @override
  FutureEither<model.User> signUp({
    required String email,
    required String password,
    required String userName,
  }) async {
    try {
      final account = await _account.create(
        userId: ID.unique(),
        email: email,
        name: userName,
        password: password,
      );
      return right(account);
    } on AppwriteException catch (e, str) {
      return left(
        Failure(str, e.toString()),
      );
    } catch (e, str) {
      return left(
        Failure(str, e.toString()),
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
    } on AppwriteException catch (e, str) {
      return left(
        Failure(
          str,
          e.toString(),
        ),
      );
    } catch (e, str) {
      return left(
        Failure(
          str,
          e.toString(),
        ),
      );
    }
  }

  @override
  Future<model.User?> currentUser() async {
    try {
      return await _account.get();
    } on AppwriteException {
      return null;
    } catch (e) {
      return null;
    }
  }
}
