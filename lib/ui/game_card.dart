import 'package:flutter/material.dart';
import '../models/game_model.dart';


class GameCard extends StatelessWidget {

  final GameModel game;

  GameCard({this.game});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 10.0,
      child: Container(
        height: 100.0,
        child: Row(children: <Widget>[
          Expanded(
            child: Text('${game.name}')
            )
        ],
        )
      )
    );
  }

  
}