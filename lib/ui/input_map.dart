import 'package:flutter/material.dart';
import 'package:using_bottom_nav_bar/logic/beacon_manager.dart';
import 'package:using_bottom_nav_bar/logic/event_manager.dart';
import 'package:using_bottom_nav_bar/logic/position_manager.dart';
import 'package:using_bottom_nav_bar/logic/virtual_map.dart';
import 'package:using_bottom_nav_bar/models/position.dart';
import 'package:using_bottom_nav_bar/ui/map_widget.dart';

class InputMap extends MapWidget {

  @override
  _InputMapState createState() => _InputMapState();

  VirtualMap virtualMap;

  InputMap({Key key, this.virtualMap})
    : super(key: key);
}

class _InputMapState extends MapWidgetState {

  @override
  initState() {
    super.initState();
  }

  void _handleCellTap(int x, int y) {
    if(this.mounted) {
      setState(() {
        print("Tap on cell ($x, $y)");
        widget.virtualMap.addAnchor(x, y, 'toto');
      });
    }
  }

  void _handleCellDoubleTap(int x, int y) {
    if(this.mounted) {
      setState(() {
        print("Double tap on cell ($x, $y)");
        widget.virtualMap.removeAnchor(x, y);
      });
    }
  }

  @override
  Widget buildCellItem(int row, int column) {
    Object locatedObject = this.widget.virtualMap.getObject(column, row);
    Widget child = null;
    if(locatedObject is BeaconAnchor) {
      child = buildBeaconAnchorsMarker();
    }
    return buildCellButton(row, column, child);
  }

  Widget buildCellButton(row, column, child) {
    return GestureDetector(
      onTap: () => _handleCellTap(column, row),
      onDoubleTap: () => _handleCellDoubleTap(column, row),
      child: child
    ); 
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