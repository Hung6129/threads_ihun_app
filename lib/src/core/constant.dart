class AppwriteConstants {
  static const String endPoint = 'http://localhost:80/v1';

  static const String projectId = '64b52aca78a2e06a31f3';

  static const String databaseId = '64b54b9a14ae4b2e091d';

  static const String usersCollectionId = '64cb3ac54a8b36ae4629';

  static const String postsCollectionId = '64b6cbcc436ffa35ba9c';

  static const String imagesBucket = '64b6d3567158ace182e3';

    static String imageUrl(String imageId) =>
      '$endPoint/storage/buckets/$imagesBucket/files/$imageId/view?project=$projectId&mode=admin';
}
