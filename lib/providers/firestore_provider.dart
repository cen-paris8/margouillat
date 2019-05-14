import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreProvider {
  Firestore _firestore = Firestore.instance;

  Stream<QuerySnapshot> gameListEvents() {
    return _firestore
        .collection('games')
        .snapshots();
  }

}