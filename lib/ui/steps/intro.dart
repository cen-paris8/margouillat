import 'dart:io';

import 'package:flutter/material.dart';
import '../../models/step_model.dart';

class IntroStep extends StatelessWidget {

  final IntroStepModel model;

  IntroStep({this.model});

  @override
  Widget build(BuildContext context) {
    return new Card(
        color: Colors.white,
        elevation: 10.0,
        child: Container(
          height: 100.0,
          child: Row(children: <Widget>[
            Expanded(
              child: Text(this.model.title)
              ),
            Expanded( 
              //child: Image.network('${snapshot.data.thumbnailUrl}')
              child: Image.file(File(this.model.image))
              ),
            Expanded(
              child: Text(this.model.image)
              ),
              ],
            )
          )
        );
      } 
}