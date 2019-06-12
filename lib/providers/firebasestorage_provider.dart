import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageProvider {

  static final FirebaseStorageProvider _instance =
      new FirebaseStorageProvider.internal();

  FirebaseStorageProvider.internal();

  factory FirebaseStorageProvider() {
    return _instance;
  }
  
  static final _thumbnailDirPath = '/thumbnail';
  static final _thumbnailPath =  _thumbnailDirPath + '/images_game.jpg';
  static final _homeDirPath = '/home';
  static final _resourcesDirPath = '/'; 
  
  Future<Null> downloadFile(String httpPath, String filePath) async {
    print('Looking on firebase for file with path: $httpPath');
    StorageReference ref = FirebaseStorage.instance.ref().child(httpPath);
    File file = File(filePath);
    // TODO : check if file already exists or is updated
    if(file.existsSync()) {
      return;
    }
    StorageFileDownloadTask downloadTask = ref.writeToFile(file);
    int byteNumber = (await downloadTask.future).totalByteCount;
  }

  String getGameThumbnailDirPath(String urlId) {
    String gamePublicPath = getGamePublicPath(urlId);
    return gamePublicPath + _thumbnailDirPath;
  }

  String getGameThumbnailPath(String urlId) {
    String gamePublicPath = getGamePublicPath(urlId);
    return gamePublicPath + _thumbnailPath;
  }

  String getGameResourcesDirPath(String urlId) {
    String gamePublicPath = getGamePublicPath(urlId);
    return gamePublicPath + _resourcesDirPath;
  }

  String getGameResourcesPath(String urlId, String path) {
    String gameResourcesDirPath = getGameResourcesDirPath(urlId);
    String resPath = gameResourcesDirPath + path;
    // TODO : check if really necessary (only used to avoid bad input in db)
    return resPath.replaceAll(' ', '');
  }

  String getGamePublicPath(String urlId) {
    // TODO : set env from configuration or environment variable
    String env = "dev";
    return "$env/tg/$urlId/public";
  }

}