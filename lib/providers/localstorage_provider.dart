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
    this._initAppDocDirPath();
  }


  void _initAppDocDirPath() async {
    if(this._appDocDirPath == null || this._appDocDirPath.isEmpty) {
      Directory appDocDirectory = await getApplicationDocumentsDirectory();
      this._appDocDirPath = appDocDirectory.path;
    } 
  }

  String getAppDocDirPath() {
    if(_appDocDirPath == null || _appDocDirPath.isEmpty) {
      _initAppDocDirPath();
    } 
    return _appDocDirPath;
  }

/*
  Future<String> getAppDocDirPath() async {
    if(_appDocDirPath == null || _appDocDirPath.isEmpty) {
      Directory appDocDirectory = await getApplicationDocumentsDirectory();
      _appDocDirPath = appDocDirectory.path;
    } 
    
    return _appDocDirPath;
  }
*/

  String getGameThumbnailPath(String urlId) {
    String gameThumbnailDirPath = _getGameSubDirPath(urlId, 'thumbnail');
    String gameThumbnailPath = path.join(gameThumbnailDirPath, 'images_game.jpg');
    return gameThumbnailPath;
  }

  String _getGameSubDirPath(String urlId, String subDirPath) {
    String gamePublicPath = _getGamePublicDirPath(urlId);
    String gameSubDirPath = path.join(gamePublicPath, subDirPath);
    Directory dir = new Directory(gameSubDirPath);
    if(!dir.existsSync()) {
      dir.createSync(recursive: true);
    }
    return gameSubDirPath;
  }

  String _getGamePublicDirPath(String urlId) {
    String appDocDirectoryPath = getAppDocDirPath();
    print('Application document directory is located at: $appDocDirectoryPath');
    return path.join(appDocDirectoryPath, urlId, 'public');
  }

  String _getGameResourcesDirPath(String urlId) {
    String appGamePublicPath = _getGamePublicDirPath(urlId);
    return appGamePublicPath;
  }

  String getGameResourcePath(String urlId, String resPath) {
    String appGameResourcesPath = _getGameResourcesDirPath(urlId);
    return path.join(appGameResourcesPath, resPath);
  }


  Future<Null> createGameArborescence(String urlId) async {
    String gameThumbnailDirPath = _getGameSubDirPath(urlId, 'thumbnail');
    String gameHomeDirPath = _getGameSubDirPath(urlId, 'home');
  }



}