import 'package:flutter/material.dart';
import 'package:using_bottom_nav_bar/logic/game_manager.dart';
import 'package:using_bottom_nav_bar/models/game_model.dart';
import 'package:using_bottom_nav_bar/models/step_model.dart';
import 'package:using_bottom_nav_bar/ui/event_simulator.dart';
import 'package:using_bottom_nav_bar/ui/steps/intro.dart';
import 'package:using_bottom_nav_bar/ui/steps/mcq.dart';
import 'package:flutter/foundation.dart';
import 'dart:developer';

class GamePlayer extends StatelessWidget {

  final GameManager _gameManager = new GameManager('c9i6O9d0jj6LS96Kvm8L');

  @override
  Widget build(BuildContext context) {
    debugPrint('In GamePlayer');
    return  Scaffold(
      body: new Container(
        alignment: Alignment.center,
        child: new Column(
          children: <Widget>[
            new Container(
              child: new StreamBuilder( 
                stream: _gameManager.gameEventStream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return new Text('Loading..');
                  GameEvent e = snapshot.data;
                  BaseStepModel model = e.step.model;
                  print('Game event received');
                  if(e.step.model.type == StepType.QCM) {
                    return new MCQWidget(
                      model: model
                    );
                  } else {
                    return new IntroStep(
                      model: model
                    );
                  }                 
                }
              )
            ),
            new Padding(padding: EdgeInsets.all(10.0)),
            new EventSimulator()
          ]
        )
      )
    );
  }

}