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

  /*
  Future<String> getFilePath(String httpPath) async {
    final RegExp regExp = RegExp('([^?/]*\.(jpg|mp4|mp3))');
    String fileName = regExp.stringMatch(httpPath);
    final RegExp regExpDir = RegExp('([^?/]*\)/\.*');
    String dirPath = regExp.stringMatch(fileName);
    print(dirPath);
    //String dirPath = fileName.split('/')
    //String fileName = httpPath.replaceAll('/', '_');
    //String fileName = httpPath
    //final Directory tempDir = Directory.systemTemp;
    //final String tempPath = '${tempDir.path}/$fileName';
    //String tempPath = '${tempDir.path}/$fileName';     
    //String tempPath = await getLocalFile(fileName);
    //Future<Null> result = downloadFile(httpPath, tempPath);   
    StorageReference ref = FirebaseStorage.instance.ref().child(httpPath);
    String tempPath = await ref.getDownloadURL();
    return tempPath;
  }
  */
  
  Future<Null> downloadFile(String httpPath, String filePath) async {
    StorageReference ref = FirebaseStorage.instance.ref().child(httpPath);
    String tempPath = await ref.getDownloadURL();
    print(tempPath);
    File file = File(filePath);
    print(filePath);
    // TODO : check if file already exists or is
    /*
    if(file.existsSync()) {
      DateTime lastModified = file.lastModifiedSync();
    }
    */
    StorageFileDownloadTask downloadTask = ref.writeToFile(file);
    int byteNumber = (await downloadTask.future).totalByteCount;
    print(byteNumber); 
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<String> getLocalFile(fileName) async {
    final path = await _localPath;
    return '$path/$fileName';
  }

  Future<Directory> createGameArborescence(String gameId) async {
    Directory appDocDirectory = await getApplicationDocumentsDirectory();
    return new Directory(appDocDirectory.path + '/' + 'gameId' + '/' + 'public' + '/' + 'thumbnai')
    .create(recursive: true);
  }

}