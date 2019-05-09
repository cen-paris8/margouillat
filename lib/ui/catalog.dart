import 'package:flutter/material.dart';
import 'game_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/game_model.dart';
import 'package:flutter/foundation.dart';
import 'dart:developer';

class GameCatalog extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    //GameModel g = new GameModel('toto');
    debugPrint('Ici');
    debugger();
    return new StreamBuilder(
      stream: Firestore.instance.collection('games').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return new Text('Loading..');
        return GridView.count(
          crossAxisCount: 2,
          scrollDirection: Axis.vertical,
          children: snapshot.data.documents.map<Widget>((document) {
              return new GameCard(
                game: new GameModel(document['name'])
              );
            }
          ).toList(),
        );
      }
    );
  }
}