import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:developer';
import 'package:path_provider/path_provider.dart';

class LocalStorageProvider {

  static final LocalStorageProvider _instance =
      new LocalStorageProvider.internal();

  LocalStorageProvider.internal();

  factory LocalStorageProvider() {

    return _instance;
  }

}