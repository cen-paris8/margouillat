import 'dart:developer';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';
import 'package:test/test.dart';
import '../lib/models/game_model.dart';
import '../lib/providers/firebasestorage_provider.dart';
import '../lib/providers/firestore_provider.dart';
import '../lib/providers/localstorage_provider.dart';
import '../lib/repositories/game_repository.dart';
import 'package:path_provider/path_provider.dart' as PathProvider;

void main() {

  /*
  const MethodChannel('plugins.flutter.io/path_provider')
  .setMockMethodCallHandler((MethodCall methodCall) async {
    if (methodCall.method == 'getApplicationDocumentsDirectory') {
      return new Directory('/toot/'); // set initial values here if desired
    }
    return null;
  });
  */
  
  test('Get local game directory path', () async {
    //final FirebaseStorageProvider _firebasestorageProvider = new FirebaseStorageProvider();
    //final String httpPath = 'dev/tg/$urlId/public/thumbnail/images_game.jpg";'
    //_firebasestorageProvider.getFilePath(httpPath);
    final LocalStorageProvider _localStorage = new LocalStorageProvider();
    String path = await _localStorage.getAppDocDirPath();
    print(path);
    expect(path, isNotNull);
    expect(path.isNotEmpty, isTrue);
  });

  test('Get game data from firestore', () async {
    final GameRepository _repository = new GameRepository();
    Observable<GameModel> oGame = _repository.getGame('rBnjvYj5K');
    GameModel game = await oGame.single;
    debugger();
    print(game);
    expect(game, isNotNull);
  });

}