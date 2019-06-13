import 'package:flutter/material.dart';
import 'package:using_bottom_nav_bar/logic/beacon_manager.dart';
import 'package:using_bottom_nav_bar/logic/event_manager.dart';
import 'package:using_bottom_nav_bar/logic/position_manager.dart';
import 'package:using_bottom_nav_bar/logic/virtual_map.dart';
import 'package:using_bottom_nav_bar/models/position.dart';
import 'package:using_bottom_nav_bar/ui/map_widget.dart';

class GameMap extends MapWidget {

  @override
  _GameMapState createState() => _GameMapState();

  VirtualMap virtualMap;

  GameMap({Key key, this.virtualMap})
    : super(key: key);
}

class _GameMapState extends MapWidgetState {

  final EventManager _eventManager = EventManager();
  Position _playerPosition = new Position(0, 0);
  BeaconManager beaconManager;
  PositioningManager positionManager;
  double cellSize = 0;
  
  @override
  initState() {
    super.initState();
    beaconManager = BeaconManager();
    positionManager = PositioningManager();
    _eventManager.addPositionEventListener(_processPosition);
  }

  void _processPosition(var event) {
    print("Handling Position event in map");
    if(this.mounted) {
      setState(() {
        _playerPosition = event.position;
      });
    }
  }

  @override
  Widget buildCellItem(int row, int column) {
    if(row == this._playerPosition.y.round() && column == this._playerPosition.x.round())
      return buildCurrentPositionMarker();
    Object locatedObject = this.widget.virtualMap.getObject(column, row);
    if(locatedObject is BeaconAnchor) {
      return buildBeaconAnchorsMarker();
    }
    return buildEmptyCell();
  }

  Widget buildCurrentPositionMarker() {
    return buildCircle(5, Colors.red);
  }

  Widget buildBeaconAnchorsMarker() {
    return buildCircle(5, Colors.black);
  }

  @override
  void dispose() {
    super.dispose();
  }

}