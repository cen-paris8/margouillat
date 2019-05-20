import 'dart:io';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import '../../models/step_model.dart';

class QCMStep extends StatelessWidget {

  final Observable<QCMStepModel> step;

  QCMStep({this.step});

  @override
  Widget build(BuildContext context) {
    return new StreamBuilder(
      stream: step,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return new Text('');
        return new Card(
        color: Colors.white,
        elevation: 10.0,
        child: Container(
          height: 100.0,
          child: Row(children: <Widget>[
            Expanded(
              child: Text('${snapshot.data.name}')
              ),
            Expanded( 
              //child: Image.network('${snapshot.data.thumbnailUrl}')
              child: Image.file(File(snapshot.data.thumbnailPath))
              ),
            Expanded(
              child: Text('${snapshot.data.thumbnailPath}')
              )
              ],
            )
          )
        );
      }
    );
  }

  
}