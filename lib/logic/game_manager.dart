
import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:using_bottom_nav_bar/logic/event_manager.dart';
import 'package:using_bottom_nav_bar/models/game_model.dart';
import 'package:using_bottom_nav_bar/models/step_model.dart';
import 'package:using_bottom_nav_bar/repositories/game_repository.dart';

class Game {
  GameModel model;
  String playerId;
  int score;

  BaseStepModel getStepByIndex(int index) {
    BaseStepModel model = this.model.steps.singleWhere((s) => s.index == index);
    // TODO : check if model is not found
    return model;
  }

}

class Step {
  BaseStepModel model;
  bool isVisited;
  bool isCompleted;
  bool isVisible;

  Step.fromModel(this.model);
}


class GameEvent {
  Step step;
}

class GameManager {

  String _gameId;
  Game game;
  Step activeStep;
  List<Step> steps = new List<Step>();
  final EventManager _eventManager = EventManager();
  final GameRepository _gameRepository = new GameRepository();
  StreamController _gameEventsController = new StreamController.broadcast();

  Stream get gameEventStream => _gameEventsController.stream;

  GameManager(this._gameId){
    this.game = new Game();
    this._getGame(this._gameId);
  }

  void _getGame(String gameId) {
    Observable<GameModel> oModel = _gameRepository.getGame(gameId);
    oModel.first.then((model) =>
      this.game.model = model
    ).then((model) =>
      this._startGame()
    );
  }

  void _handleEvent(var data){
    // TODO : switch according event type and values (e.g. geoloc event, beacon, nfc, qrcode, ui, time)
    int stepIndex = int.parse(data);
    BaseStepModel nextStepModel = this.game.getStepByIndex(stepIndex);
    Step nextStep = Step.fromModel(nextStepModel);
    GameEvent gameEvent = new GameEvent();
    gameEvent.step = nextStep;
    _gameEventsController.add(gameEvent);
  }



  void _startGame() {
     // get player
     // save session start
     // start listening to events
     _eventManager.addUIEventHandler((data) => {
      _handleEvent(data)
      }
    );
  }

}