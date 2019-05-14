import 'package:flutter/material.dart';
import 'game_card.dart';
import '../repositories/game_repository.dart';
import 'package:flutter/foundation.dart';
import 'dart:developer';

class GameCatalogRx extends StatelessWidget {

  final GameRepository _gameRepository = new GameRepository();

  @override
  Widget build(BuildContext context) {
    //GameModel g = new GameModel('toto');
    debugPrint('In GameCatalogRx');
    return new StreamBuilder(
      stream: _gameRepository.gameList(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return new Text('Loading..');
        return GridView.count(
          crossAxisCount: 2,
          scrollDirection: Axis.vertical,
          children: snapshot.data.map<Widget>((gameModel) {
              return new GameCard(
                game: gameModel
              );
            }
          ).toList(),
        );
      }
    );
  }
}