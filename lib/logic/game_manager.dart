
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

  GameManager(this._gameId){
    this.game = new Game();
  }

  void _getGame(String gameId) {
    Observable<GameModel> oModel = _gameRepository.getGame('c9i6O9d0jj6LS96Kvm8L');
    oModel.first.then((model) =>
      this.game.model = model
    ).then((model) =>
      this._startGame()
    );
  }

  void _handleEvent(String data){
    BaseStepModel nextStepModel = this.game.getStepByIndex(2);
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

  /*
  Stream<String> stream = new Stream.fromFuture(getData());
  print("Created the stream");

  stream.listen((data) {
    print("DataReceived: "+data);
  }, onDone: () {
    print("Task Done");
  }, onError: (error) {
    print("Some Error");
  });
  */

}