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
}
