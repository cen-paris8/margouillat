import 'package:cloud_firestore/cloud_firestore.dart';

import '../providers/firestore_provider.dart';
import '../models/game_model.dart';
import 'package:rxdart/rxdart.dart';

class GameRepository {

  final FirestoreProvider _firestoreProvider = new FirestoreProvider();

  Observable<Iterable<GameModel>> gameList() {
    Stream<QuerySnapshot> sqs = _firestoreProvider.gameListEvents();
    /*
    Future<QuerySnapshot> f = sqs.first;
    f.then((QuerySnapshot q) { 
      print(q); 
      print(q.documents.first.documentID);
      q.documents.forEach((DocumentSnapshot ds) {
        print(ds.data['name']);
      });
    });
    */

    //Future<QuerySnapshot> f = sqs.first;
    /*
    f.then((QuerySnapshot q) { 
      print(q); 
      print(q.documents.first.documentID);
      q.documents.forEach((DocumentSnapshot ds) {
        print(ds.data['name']);
      });
    })
    */
    /*
    f.then((QuerySnapshot qs) {
      print(qs); 
      print(qs.documents.first.documentID);
      qs.documents.forEach((DocumentSnapshot ds) {
        print(ds.data['name']);
      });
      //return new Observable.fromIterable(qs.documents.toList());
      return new Observable(Stream.fromIterable(qs.documents.map(
          (ds) => _toGameModel(ds)
        )));
      }
    ).catchError(
      return new Observable(Null);
    );
    */
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