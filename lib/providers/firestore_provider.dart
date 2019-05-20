import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreProvider {
  Firestore _firestore = Firestore.instance;
  /*
  FirebaseFirestore _firestore = FirebaseFirestore.getInstance();

  FirebaseFirestoreSettings settings = new FirebaseFirestoreSettings.Builder()
    .setTimestampsInSnapshotsEnabled(true)
    .build();
  _firestore.setFirestoreSettings(settings);
  */
  Stream<QuerySnapshot> gameListEvents() {
    return _firestore
        .collection('games')
        .snapshots();
  }

  Stream<DocumentSnapshot> getGame(String gameId) {
    return _firestore
        .collection('games')
        .document(gameId)
        .snapshots();
  }

  Stream<QuerySnapshot> getGameSteps(String gameId) {
    return _firestore
        .collection('games')
        .document(gameId)
        .collection('steps')
        .snapshots();
  }

}