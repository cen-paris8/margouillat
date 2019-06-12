import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import '../providers/firestore_provider.dart';
import '../providers/firebasestorage_provider.dart';
import '../providers/localstorage_provider.dart';
import '../models/game_model.dart';
import '../models/step_model.dart';


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

  Observable<GameModel> getGame(String gameId) {
    Stream<DocumentSnapshot> sds = _firestoreProvider.getGame(gameId);
    Future<GameModel> game = sds.first.then(
     (ds) => _toFullGameModel(ds)
    );
    return Observable.fromFuture(game);
  }

  Future<GameModel> _toGameModel(DocumentSnapshot snapshot) async {
    GameModel game = GameModel(snapshot.data['name']);
    game.urlId = snapshot.data['url_id'];
    game.thumbnailUrl = _firebasestorageProvider.getGameThumbnailPath(game.urlId);
    game.thumbnailPath = _localstorageProvider.getGameThumbnailPath(game.urlId);
    await _firebasestorageProvider.downloadFile(game.thumbnailUrl, game.thumbnailPath);
    return game;
  }

  Future<List<DocumentSnapshot>> getGameStepDocuments(String gameId) async {
    Stream<QuerySnapshot> sqs = _firestoreProvider.getGameSteps(gameId);
    Stream<List<DocumentSnapshot>> stepStream = sqs.map(
      (qs) => qs.documents
    );
    Future<List<DocumentSnapshot>> stepList = stepStream.first;
    return stepList;
  }

  Future<GameModel> _toFullGameModel(DocumentSnapshot snapshot) async {
    var data = snapshot.data;
    var gameId = snapshot.documentID;
    GameModel game = GameModel.fromSnaphot(
      gameId,
      data['name'],
      data['url_id'],
      data['shortDescription'],
      data['description']
      );
    print('Loading data from firestore');
    List<DocumentSnapshot> stepsSnapshot = await getGameStepDocuments(gameId);
    print('Nb of steps retrieved: ${stepsSnapshot.length}');
    for (var ss in stepsSnapshot) {
      var dq = ss.data;
      BaseStepModel base = BaseStepModel.fromSnapthot(
        dq['type'],
        dq['index'],
        dq['title'],
        dq['shortDescription'],
        dq['description'],
        dq['info']
      );
      String type = dq['type'];
      print(base);
      AbstractStep step;
      switch (type) {
        case StepType.Intro: {
            step = new IntroStepModel(base)
              ..image = _localstorageProvider.getGameResourcePath(game.urlId, dq['image']);
            // TODO : launch image download
            this._launchAsyncDownload(game.urlId, dq['image']);
          }
          break;
        case StepType.MapIn: {
            step = new MapInStepModel(base);
          }
          break;
        case StepType.Map: {
            step = new MapStepModel(base)
              ..lng = double.parse(dq['lng'])
              ..lat = double.parse(dq['lat']);
          }
          break;
        case StepType.MCQ: {
            print('Mapping for MCQ');
            step = new MCQStepModel.fromBaseStep(base)
              ..winMsg = dq['winMsg']
              ..correctAnswser = dq['correctAnswer']
              ;
            (step as MCQStepModel).addChoices(List.from(dq['choices']));
            (step as MCQStepModel).addErrMessages(List.from(dq['errorMsg']));
          }
          break;
          // TODO : for all field referencing resources stored in fb storage, it is the place to launch async download to local filesystem
        default:
          // TODO : log unknown step type
          break;
      }
      game.addStep(step);
      print('Step added: ${base.title}');
    }
    return game;
  }

  Future<Null> _launchAsyncDownload(urlId, path) async {
    String fbPath = _firebasestorageProvider.getGameResourcesPath(urlId, path);
    String localPath = _localstorageProvider.getGameResourcePath(urlId, path);
    _firebasestorageProvider.downloadFile(fbPath, localPath);
  }

}