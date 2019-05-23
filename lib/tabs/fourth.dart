import 'package:flutter/material.dart';
import '../ui/catalog.dart';
import '../ui/catalogRx.dart';
import '../ui/game_player.dart';
import '../ui/event_simulator.dart';


class FourthTab extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    //return GameCatalog();
    //return GameCatalogRx();
    return GamePlayer();
    //return EventSimulator();
  }
}