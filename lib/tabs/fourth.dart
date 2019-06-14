import 'package:flutter/material.dart';
import 'package:using_bottom_nav_bar/logic/virtual_map.dart';
import 'package:using_bottom_nav_bar/repositories/beacon_repository.dart';
import 'package:using_bottom_nav_bar/ui/input_map.dart';
import 'package:using_bottom_nav_bar/ui/game_map.dart';
import 'package:using_bottom_nav_bar/ui/map_widget.dart';
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
    // For test
    /*
    BeaconRepository _beaconRepository = BeaconRepository();
    List<BeaconAnchor> anchors = _beaconRepository.getBeaconAnchors('dummyGameId');
    VirtualMap vMap = new VirtualMap(10, 16);
    for(BeaconAnchor anchor in anchors) {
      vMap.addAnchorObject(anchor);
    }
    return GameMap(virtualMap: vMap,);
    */
    //VirtualMap emptyMap = new VirtualMap(10, 10);
    //return InputMap(virtualMap: emptyMap,);
    //return MapWidget(virtualMap: vMap,);
  }
}