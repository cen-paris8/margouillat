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

}