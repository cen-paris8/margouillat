import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import '../providers/firestore_provider.dart';
import '../providers/firebasestorage_provider.dart';
import '../models/game_model.dart';


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
    print(snapshot.data['name']);
    print(snapshot.data['url_id']);    
    game.thumbnailUrl = await _getThumbnailUrl(snapshot.data['url_id']);
    return game;
  }

  Future<String> _getThumbnailUrl(String urlId) {
    String urlPath = "dev/tg/$urlId/public/thumbnail/images_game.jpg";
    return _firebasestorageProvider.getFilePath(urlPath);
  }
}