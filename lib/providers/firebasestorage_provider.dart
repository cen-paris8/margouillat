import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:developer';

class FirebaseStorageProvider {

  static final FirebaseStorageProvider _instance =
      new FirebaseStorageProvider.internal();

  FirebaseStorageProvider.internal();

  factory FirebaseStorageProvider() {
    return _instance;
  }

  static final _thumbnailDirPath = 'thumbnail';
  static final _thumbnailPath =  _thumbnailDirPath + '/images_game.jpg';
  static final _homeDirPath = 'home';
  static final _resourcesDirPath = ''; 
  
  Future<Null> downloadFile(String httpPath, String filePath) async {
    StorageReference ref = FirebaseStorage.instance.ref().child(httpPath);
    File file = File(filePath);
    // TODO : check if file already exists or is updated
    if(file.existsSync()) {
      return;
    }
    StorageFileDownloadTask downloadTask = ref.writeToFile(file);
    int byteNumber = (await downloadTask.future).totalByteCount;
    print(byteNumber); 
  }

  String getGameThumbnailDirPath(String gameId) {
    String gamePublicPath = getGamePublicPath(gameId);
    return gamePublicPath + _thumbnailDirPath;
  }

  String getGameThumbnailPath(String gameId) {
    String gamePublicPath = getGamePublicPath(gameId);
    return gamePublicPath + _thumbnailPath;
  }

  String getGameResourcesDirPath(String gameId) {
    String gamePublicPath = getGamePublicPath(gameId);
    return gamePublicPath + _resourcesDirPath;
  }

  String getGamePublicPath(String gameId) {
    // TODO : set env from configuration or environment variable
    String env = "dev";
    return "$env/tg/$gameId/public";
  }

}