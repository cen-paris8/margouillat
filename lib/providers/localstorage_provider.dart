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

  Future<String> getGameThumbnailPath(String gameId) async {
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
    String appDocDirectoryPath = await getAppDocDirPath();
    return path.join(appDocDirectoryPath, gameId, 'public');
  }

  Future<Null> createGameArborescence(String gameId) async {
    String gameThumbnailPath = await getGameThumbnailPath(gameId);
    return new Directory(gameThumbnailPath).create(recursive: true);
  }


}