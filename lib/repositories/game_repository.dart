import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import '../providers/firestore_provider.dart';
import '../providers/firebasestorage_provider.dart';
import '../providers/localstorage_provider.dart';
import '../models/game_model.dart';
import 'package:path_provider/path_provider.dart';


class GameRepository {

  final FirestoreProvider _firestoreProvider = new FirestoreProvider();
  final FirebaseStorageProvider _firebasestorageProvider = new FirebaseStorageProvider();
  final LocalStorageProvider _localstorageProvider = new LocalStorageProvider();

  Observable<Iterable<Observable<GameModel>>> gameList() {
    Stream<QuerySnapshot> sqs = _firestoreProvider.gameListEvents();
    Future<Iterable<Observable<GameModel>>> gameList = sqs.first.then(
     (qs) => qs.documents.map(
        (ds) => new Observable.fromFuture(_toGameModel(ds))
      )
    );
    return new Observable.fromFuture(gameList);
  }

  Future<GameModel> _toGameModel(DocumentSnapshot snapshot) async {
    GameModel game = GameModel(snapshot.data['name']);
    String gameId = snapshot.data['url_id'];
    print(snapshot.data['name']);
    print(snapshot.data['url_id']);
    game.thumbnailUrl = _firebasestorageProvider.getGameThumbnailPath(gameId);
    game.thumbnailPath = await _localstorageProvider.getGameThumbnailPath(gameId);
    await _firebasestorageProvider.downloadFile(game.thumbnailUrl, game.thumbnailPath);
    return game;
  }

  
}