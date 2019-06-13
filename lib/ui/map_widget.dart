import 'dart:math';

import 'package:flutter/material.dart';
import 'package:using_bottom_nav_bar/logic/beacon_manager.dart';
import 'package:using_bottom_nav_bar/logic/event_manager.dart';
import 'package:using_bottom_nav_bar/logic/position_manager.dart';
import 'package:using_bottom_nav_bar/logic/virtual_map.dart';
import 'package:using_bottom_nav_bar/models/position.dart';

class MapWidget extends StatefulWidget {

  @override
  MapWidgetState createState() => MapWidgetState();

  VirtualMap virtualMap;

  MapWidget({Key key, this.virtualMap})
    : super(key: key);
}

class MapWidgetState extends State<MapWidget> {

  double cellSize = 0;
  
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new StreamBuilder(
      stream: null,
      builder: (context, snapshot) {
        //if (!snapshot.hasData) return new Text('Loading..');
        return Container ( 
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              cellSize = _getCellSize(constraints.maxHeight, widget.virtualMap.height, constraints.maxWidth, widget.virtualMap.width);
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildField(widget.virtualMap.height, widget.virtualMap.width)
                ]
              );
            }
          )
        );
      }
    );
  }

  double _getCellSize(maxHeight, nbRows, maxWidth, nbColumns) {
    double maxCellHeight = (maxHeight-(maxHeight*0.25)) / nbRows;
    double maxCellWidth = maxWidth / nbColumns;
    double size = min(maxCellHeight, maxCellWidth);
    return size;
  }

  Widget buildField(int nbRow, int nbColumn) {
    return AspectRatio(
      aspectRatio: 1.0,
      child:
        Column(
          verticalDirection: VerticalDirection.up,
          mainAxisAlignment: MainAxisAlignment.center, 
          children: buildRows(nbRow, nbColumn)
        )
      );
  }

  List<Widget> buildRows(int nbRows, int nbColumns) {
    List<Widget> rows = List<Widget>();
    for(int i=0; i < nbRows; i++) {
      rows.add(buildRow(i, nbColumns));
    }
    return rows;
  }
  
  Widget buildRow(int rowIndex, int nbColumn) {
    return Container (
      padding: EdgeInsets.all(0.0),
      margin: EdgeInsets.all(0.0), 
      child: Row(
        children: buildCells(rowIndex, nbColumn)
      )
    );
  }



  List<Widget> buildCells(int rowIndex, int nbCells) {
    List<Widget> cells = List<Widget>();
    for(int i=0; i < nbCells; i++) {
      cells.add(buildCell(rowIndex, i));
    }
    return cells;
  }

  Widget buildCell(int row, int column) {
    return Container(
      width:cellSize,
      height:cellSize,
      padding: EdgeInsets.all(0.0),
      margin: EdgeInsets.all(0.0), 
      decoration: BoxDecoration(         
        color: Colors.white,
        shape: BoxShape.rectangle,
        border: Border.all(color: Colors.grey),
      ),
      child: buildCellItem(row, column)
    );
 }

  Widget buildCellItem(int row, int column) {
    /*
    Object locatedObject = this.widget.virtualMap.getObject(column, row);
    if(locatedObject is BeaconAnchor) {
      return buildBeaconAnchorsMarker();
    }
    */
    return buildEmptyCell();
  }

  Widget buildCircle(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: new BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      )
    );
  }

  /*
  Widget buildCurrentPositionMarker() {
    return buildCircle(5, Colors.red);
  }

  Widget buildBeaconAnchorsMarker() {
    return buildCircle(5, Colors.black);
  }
  */

  Widget buildEmptyCell() {
    return Container(
      padding: EdgeInsets.all(0.0),
      margin: EdgeInsets.all(0.0), 
      );
  }

  @override
  void dispose() {
    super.dispose();
  }

}