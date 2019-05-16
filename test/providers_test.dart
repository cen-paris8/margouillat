import 'dart:io';

import 'package:flutter/services.dart';
import 'package:test/test.dart';
import '../lib/providers/firebasestorage_provider.dart';
import '../lib/providers/localstorage_provider.dart';
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
}