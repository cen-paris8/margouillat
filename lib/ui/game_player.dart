import 'package:flutter/material.dart';
import 'package:using_bottom_nav_bar/models/game_model.dart';
import 'package:using_bottom_nav_bar/models/step_model.dart';
import 'package:using_bottom_nav_bar/ui/steps/intro.dart';
import '../repositories/game_repository.dart';
import 'package:flutter/foundation.dart';
import 'dart:developer';

class GamePlayer extends StatelessWidget {

  final GameRepository _gameRepository = new GameRepository();

  @override
  Widget build(BuildContext context) {
    //GameModel g = new GameModel('toto');
    debugPrint('In GamePlayer');
    return new StreamBuilder( 
      stream: _gameRepository.getGame('c9i6O9d0jj6LS96Kvm8L'),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return new Text('Loading..');
        GameModel gm = snapshot.data;
        print('${gm.steps.length} steps in this game');
        BaseStepModel intro = gm.steps.first;
        return new IntroStep(
          model: intro
        );
      }
    );
  }

}