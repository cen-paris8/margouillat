import 'package:flutter/material.dart';
import 'package:using_bottom_nav_bar/logic/game_manager.dart';
import 'package:using_bottom_nav_bar/models/step_model.dart';
import 'package:using_bottom_nav_bar/ui/event_simulator.dart';
import 'package:using_bottom_nav_bar/ui/steps/debug.dart';
import 'package:using_bottom_nav_bar/ui/steps/intro.dart';
import 'package:using_bottom_nav_bar/ui/steps/mcq.dart';
import 'package:flutter/foundation.dart';

class GamePlayer extends StatefulWidget {

  @override
  _GamePlayerState createState() => _GamePlayerState();

  GamePlayer({Key key})
    : super(key: key);
}

class _GamePlayerState extends State<GamePlayer> {

  final GameManager _gameManager = new GameManager('c9i6O9d0jj6LS96Kvm8L');

  Widget _buildStepWidget(BaseStepModel model) {
    switch(model.type) {
      case StepType.Intro:
        return new IntroStep(model: model);
        break;
      case StepType.MCQ:
        return new MCQWidget(model: model);
        break;
      default:
        //return new Text('Default step widget');
        return new DebugStep(model: model);
        break;
    }
  }

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
                  if (!snapshot.hasData) 
                    // TODO : return default game widget
                    return new Text('Loading..');
                  GameEvent e = snapshot.data;
                  BaseStepModel model = e.step.model;
                  print('Game event received');
                  return this._buildStepWidget(model);           
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