import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:developer';
import 'package:path/path.dart' as path;

class LocalStorageProvider {

  String _appDocDirPath;

  static final LocalStorageProvider _instance =
      new LocalStorageProvider._internal();

  factory LocalStorageProvider() {
    return _instance;
  }

  LocalStorageProvider._internal(){

  }



  Future<String> getAppDocDirPath() async {
    if(_appDocDirPath == null || _appDocDirPath.isEmpty) {
      Directory appDocDirectory = await getApplicationDocumentsDirectory();
      _appDocDirPath = appDocDirectory.path;
    } 
    return _appDocDirPath;
  }

  Future<String> getGameThumbnailPath(String urlId) async {
    String gameThumbnailDirPath = await _getGameSubDirPath(urlId, 'thumbnail');
    String gameThumbnailPath = path.join(gameThumbnailDirPath, 'images_game.jpg');
    return gameThumbnailPath;
  }

  Future<String> _getGameSubDirPath(String urlId, String subDirPath) async {
    String gamePublicPath = await _getGamePublicDirPath(urlId);
    String gameSubDirPath = path.join(gamePublicPath, subDirPath);
    Directory dir = new Directory(gameSubDirPath);
    if(!dir.existsSync()) {
      dir.createSync(recursive: true);
    }
    return gameSubDirPath;
  }

  Future<String> _getGamePublicDirPath(String urlId) async {
    String appDocDirectoryPath = await getAppDocDirPath();
    return path.join(appDocDirectoryPath, urlId, 'public');
  }

  Future<Null> createGameArborescence(String urlId) async {
    Future<String> gameThumbnailDirPath = _getGameSubDirPath(urlId, 'thumbnail');
    Future<String> gameHomeDirPath = _getGameSubDirPath(urlId, 'home');
  }



}