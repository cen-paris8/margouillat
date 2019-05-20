import 'package:flutter/material.dart';
import 'ui/myhome.dart';
import 'app_config.dart';


void main() {
  var configuredApp = new AppConfig(
    firestorageEnv: 'prd',
    child: new MaterialApp(
      title: "Margouillat",
      home: new MyHome()
      )
  );
  runApp(configuredApp);
}
