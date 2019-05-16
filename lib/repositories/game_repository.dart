import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import '../providers/firestore_provider.dart';
import '../providers/firebasestorage_provider.dart';
import '../models/game_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class GameRepository {

  final FirestoreProvider _firestoreProvider = new FirestoreProvider();
  final FirebaseStorageProvider _firebasestorageProvider = new FirebaseStorageProvider();

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
    game.thumbnailUrl = _getGameThumbnailUrl(gameId);
    game.thumbnailPath = await _getGameThumbnailPath(gameId);
    await _firebasestorageProvider.downloadFile(game.thumbnailUrl, game.thumbnailPath);
    return game;
  }

  String _getGameThumbnailUrl(String urlId) {
    String urlPath = "dev/tg/$urlId/public/thumbnail/images_game.jpg";
    return urlPath;
  }

  Future<String> _getGameThumbnailPath(String gameId) async {
    String gamePublicPath = await _getGamePublicDirPath(gameId);
    String gameThumbnailDirPath = path.join(gamePublicPath, 'thumbnail');
    Directory dir = new Directory(gameThumbnailDirPath);
    if(!dir.existsSync()) {
      dir.createSync(recursive: true);
    }
    String gameThumbnailPath = path.join(gameThumbnailDirPath, 'images_game.jpg');
    return gameThumbnailPath;
  }

  Future<String> _getGamePublicDirPath(String gameId) async {
    Directory appDocDirectory = await getApplicationDocumentsDirectory();
    return path.join(appDocDirectory.path, gameId, 'public');
  }

  Future<Null> createGameArborescence(String gameId) async {
    String gameThumbnailPath = await _getGameThumbnailPath(gameId);
    return new Directory(gameThumbnailPath).create(recursive: true);
  }

  
}