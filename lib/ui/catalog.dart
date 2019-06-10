import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'game_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/game_model.dart';
import 'package:flutter/foundation.dart';
import 'dart:developer';
import '../providers/firestore_provider.dart';

class GameCatalog extends StatelessWidget {

  final FirestoreProvider _firestoreProvider = new FirestoreProvider();

  @override
  Widget build(BuildContext context) {
    return new StreamBuilder(
      stream: _firestoreProvider.gameListEvents(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return new Text('Loading..');
        return GridView.count(
          crossAxisCount: 2,
          scrollDirection: Axis.vertical,
          children: snapshot.data.documents.map<Widget>((document) {
              return new GameCard(
                game: new Observable<GameModel>.fromFuture(new Future<GameModel>(() => GameModel(document['name'])))
              );
            }
          ).toList(),
        );
      }
    );
  }
}