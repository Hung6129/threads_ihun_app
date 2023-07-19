import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod/riverpod.dart';
import 'package:threads_ihun_app/src/core/constant.dart';
import 'package:threads_ihun_app/src/core/type_defs.dart';
import 'package:threads_ihun_app/src/models/post_model.dart';

import '../../core/failure.dart';
import '../../core/providers.dart';

final postAPIProvider = Provider((ref) {
  return PostApi(
    db: ref.watch(appwriteDatabaseProvider),
    realtime: ref.watch(appwriteRealtimeProvider),
  );
});

abstract class IPostApi {
  Future<List<Document>> getPosts();

  FutureEither<Document> sharePost(PostModel postModel);

  Stream<RealtimeMessage> getLatestPost();
}

class PostApi implements IPostApi {
  final Databases _db;
  final Realtime _realtime;
  PostApi({required Databases db, required Realtime realtime})
      : _db = db,
        _realtime = realtime;
  @override
  Future<List<Document>> getPosts() async {
    try {
      final posts = await _db.listDocuments(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.postsCollectionId,
      );
      return posts.documents;
    } on AppwriteException catch (e, st) {
      throw Failure(e.message ?? 'Some unexpected error occurred', st);
    } catch (e, st) {
      throw Failure(e.toString(), st);
    }
  }

  @override
  FutureEither<Document> sharePost(PostModel postModel) async {
    try {
      final postDb = await _db.createDocument(
          databaseId: AppwriteConstants.databaseId,
          collectionId: AppwriteConstants.postsCollectionId,
          documentId: ID.unique(),
          data: postModel.toMap());
      return right(postDb);
    } on AppwriteException catch (e, st) {
      return left(
        Failure(
          e.message ?? 'Some unexpected error occurred',
          st,
        ),
      );
    } catch (e, st) {
      return left(Failure(e.toString(), st));
    }
  }

  @override
  Stream<RealtimeMessage> getLatestPost() {
    return _realtime.subscribe([
      'databases.${AppwriteConstants.databaseId}.collections.${AppwriteConstants.postsCollectionId}.documents'
    ]).stream;
  }
}
