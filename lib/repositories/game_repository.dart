import 'package:cloud_firestore/cloud_firestore.dart';

import '../providers/firestore_provider.dart';
import '../models/game_model.dart';
import 'package:rxdart/rxdart.dart';

class GameRepository {

  final FirestoreProvider _firestoreProvider = new FirestoreProvider();

  Observable<Iterable<GameModel>> gameList() {
    Stream<QuerySnapshot> sqs = _firestoreProvider.gameListEvents();
    Future<Iterable<GameModel>> gameList = sqs.first.then(
     (qs) => qs.documents.map(
      (ds) => _toGameModel(ds)
      )
    );
    return new Observable.fromFuture(gameList);
  }

  GameModel _toGameModel(DocumentSnapshot snapshot) {
    return new GameModel(snapshot.data['name']);
  }
}