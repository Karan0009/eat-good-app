class FirebaseConfig {
  FirebaseConfig._();
  static final Map<String, String> _collectionNames = {"users": "users"};
  static String getCollectionName(String keyName) {
    String? userCollectionName = _collectionNames[keyName];
    if (userCollectionName == null) {
      throw Exception("collection could not be found");
    }
    return userCollectionName;
  }

  static const String _storageBucketUrl = "gs://eat-good-98f6d.appspot.com";
  static String getStorageBucketUrl() {
    return _storageBucketUrl;
  }

  static const String profilePicturesFolderPath = "profile_pictures";
}
