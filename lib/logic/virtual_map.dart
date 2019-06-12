import 'package:using_bottom_nav_bar/models/position.dart';

class VirtualMap {

  int width;
  int height;
  List<List<LocatedObject>> _matrix;

  List<BeaconAnchor> anchors;

  VirtualMap(pWidth, pHeight) {
    width = pWidth;
    height = pHeight;
    anchors = new List<BeaconAnchor>();
    _matrix = new List<List<LocatedObject>>();
    initializeMap();
  }

  void initializeMap() {
    for (var i = 0; i < width; i++) {
      List<LocatedObject> list = new List<LocatedObject>();
      for (var j = 0; j < height; j++) {
        list.add(null);
      }
      _matrix.add(list);
    }
  }

  LocatedObject getObject(x, y) {
    return _matrix[x][y];
  }

  void addObject(LocatedObject object, int x, int y) {
    object.setPosition(x, y);
    _matrix[x][y] = object;
  }

  void addAnchor(int x, int y, String uuid) {
    BeaconAnchor anchor = new BeaconAnchor(x.toDouble(), y.toDouble(), uuid);
    anchors.add(anchor);
    _matrix[x][y] = anchor;
  }

  void addAnchorObject(BeaconAnchor anchor) {
    anchors.add(anchor);
    _matrix[anchor.position.x.round()][anchor.position.y.round()] = anchor;
  }

}

class LocatedObject {
  Position _position;

  LocatedObject(double x, double y) {
    _position = new Position(x, y);
    //_type = type;
  }

  void setPosition(int x, int y) {
    _position = new Position(x.toDouble(), y.toDouble());
  }

  Position get position { return _position; }
}

class BeaconAnchor extends LocatedObject {
  
  String uuid;

  BeaconAnchor(double x, double y, String uuid) : super(x, y) {
    this.uuid = uuid;
  }
  
}