import 'dart:collection';
import 'dart:math';

import 'package:using_bottom_nav_bar/logic/beacon_manager.dart';
import 'package:using_bottom_nav_bar/logic/event_manager.dart';
import 'package:using_bottom_nav_bar/logic/kalman_filter1D.dart';
import 'package:using_bottom_nav_bar/logic/virtual_map.dart';
import 'package:using_bottom_nav_bar/models/position.dart';
import 'package:using_bottom_nav_bar/repositories/beacon_repository.dart';

class PositioningManager {

  List<BeaconAnchor> _beacons;
  List<BeaconAnchorData> _beaconsData;
  Queue<Position> _positions;
  final BeaconRepository _beaconRepository = BeaconRepository();
  final EventManager _eventManager = EventManager();
  KalmanFilter1D xKFilter = new KalmanFilter1D(0.1, 2);
  KalmanFilter1D yKFilter = new KalmanFilter1D(0.1, 2);

  static final PositioningManager _instance =
      new PositioningManager._internal();

  factory PositioningManager() {
    return _instance;
  }

  PositioningManager._internal(){
    _beacons = new List<BeaconAnchor>();
    _beaconsData = new List<BeaconAnchorData>();
    _positions = new Queue<Position>();
    _init();
  }

  void _init() {
    // get beacon positions 
    _beacons = _beaconRepository.getBeaconAnchors('dummyGameId');
    for(BeaconAnchor lb in _beacons) {
      BeaconAnchorData lbd = BeaconAnchorData.fromBeacon(lb);
      _beaconsData.add(lbd);
    }
    _eventManager.addBeaconEventListener(_handleBeaconEvent);
  }

  void _handleBeaconEvent(var event) {
    for (BeaconModel bm in event.beacons) {
      if(_isRecognizedBeacon(bm)) {
        print("beacon recognized : ${bm.proximityUUID}");
        BeaconAnchorData lbd = _beaconsData.singleWhere(
          (b) => b.beacon.uuid.toLowerCase() == bm.proximityUUID.toLowerCase()
        );
        lbd.addSDistance(bm.accuracy);
      }
    }
    print("_beaconsData.length : ${_beaconsData.length}");
    List<BeaconAnchorData> usefulData = _beaconsData.where(
      (d) => !d.isEmpty
    ).toList();
    print("usefulData.length : ${usefulData.length}");
    // TODO : before trilateration check the last distances are in the same time frame 
    if(usefulData.length >= 3) { // minimum tree beacon anchors are required for trilateration
      print('Calculating position');
      Position position = calculatePosition(usefulData);
      // TODO : better the filter
      double filteredX = xKFilter.filter(position.x, 0);
      double filteredY = yKFilter.filter(position.y, 0);
      Position filteredPosition = new Position(filteredX, filteredY);
      print('Position ${position.x};${position.y}');
      print('Filtered position ${filteredPosition.x};${filteredPosition.y}');
      this._addPosition(filteredPosition);
      PositionEvent pEvent = new PositionEvent(DateTime.now(), filteredPosition);
      //this._addPosition(position);
      //PositionEvent pEvent = new PositionEvent(DateTime.now(), position);
      _eventManager.addPositionEvent(pEvent);
    }
  }

  bool _isRecognizedBeacon(BeaconModel bm) {
    // TODO : implement BeaconModel equality operator
    return _beaconsData.any(
      (b) => b.beacon.uuid.toLowerCase() == bm.proximityUUID.toLowerCase()
    );
  }

  void _addPosition(Position  position) {
    _positions.add(position);
  }

  Position get currentPostion { return _positions.last; }

  // calculate a position using trilateration
  // other implementation : https://github.com/gheja/trilateration.js/blob/master/trilateration.js
  Position calculatePosition(List<BeaconAnchorData> beaconData) {
    assert(beaconData.length >= 3);
    // if there is more than 3 beacons available, take the 3 closest
    // find the closest beacon
    beaconData.sort(
      (d1, d2) => d1.distance.compareTo(d2.distance)
    );
    BeaconAnchorData beacon1Data = beaconData[0];
    BeaconAnchorData beacon2Data = beaconData[1];
    BeaconAnchorData beacon3Data = beaconData[2];

    double xa = beacon1Data.beacon.position.x;
    double ya = beacon1Data.beacon.position.y;
    double xb = beacon2Data.beacon.position.x;
    double yb = beacon2Data.beacon.position.y;
    double xc = beacon3Data.beacon.position.x;
    double yc = beacon3Data.beacon.position.y;
    double ra = beacon1Data.distance;
    double rb = beacon2Data.distance;
    double rc = beacon3Data.distance;
    double S = (pow(xc, 2.0) - pow(xb, 2.0) + pow(yc, 2.0) - pow(yb, 2.0) + pow(rb, 2.0) - pow(rc, 2.0)) / 2.0;
    double T = (pow(xa, 2.0) - pow(xb, 2.0) + pow(ya, 2.0) - pow(yb, 2.0) + pow(rb, 2.0) - pow(ra, 2.0)) / 2.0;
    double y = ((T * (xb - xc)) - (S * (xb - xa))) / (((ya - yb) * (xb - xc)) - ((yc - yb) * (xb - xa)));
    double x = ((y * (ya - yb)) - T) / (xb - xa);
    // now x, y  is the estimated receiver position
    return new Position(x.abs(), y.abs());
  }

  


}


class BeaconAnchorData {

  BeaconAnchor beacon;
  Queue<double> _distances = new Queue();

  BeaconAnchorData.fromBeacon(this.beacon);

  void addSDistance(double value) {
    _distances.addLast(value);
  }

  double get distance { return _distances.last; }

  bool get isEmpty { return _distances.length == 0; }

}

class PositionEvent {

  DateTime date;
  Position position;

  PositionEvent(this.date, this.position);

}
