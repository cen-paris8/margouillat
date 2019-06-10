import 'dart:async';
import 'dart:math';

import 'package:using_bottom_nav_bar/logic/beacon_manager.dart';
import 'package:using_bottom_nav_bar/logic/event_manager.dart';
import 'package:using_bottom_nav_bar/models/beacon_model.dart';
import 'package:using_bottom_nav_bar/repositories/beacon_repository.dart';

class PositioningManager {

  List<LocalizedBeacon> beacons;
  final BeaconRepository _beaconRepository = BeaconRepository();
  final EventManager _eventManager = EventManager();

  static final PositioningManager _instance =
      new PositioningManager._internal();

  factory PositioningManager() {
    return _instance;
  }

  PositioningManager._internal(){
    this.beacons = new List<LocalizedBeacon>();
  }

  void _init() {
    // get beacon positions 
    this.beacons = _beaconRepository.getLocalizedBeacons('dummy');
    _eventManager.addBeaconEventListener(_handleBeaconEvent);
  }

  void _handleBeaconEvent(RangingEvent event) {
    for (BeaconModel b in event.beacons) {
      if(_isRecognizedBeacon(b)) {
      }
    }
  }

  bool _isRecognizedBeacon(BeaconModel bm) {
    // TODO : implement BeaconModel equality operator
    return this.beacons.any(
      (b) => b.uuid == bm.proximityUUID
    );
  }

  // calculate a position using trilateration
  // other implementation : https://github.com/gheja/trilateration.js/blob/master/trilateration.js
  Position calculatePosition(List<LocalizedBeaconData> beaconData) {
    assert(beaconData.length == 3);
    // if there is more than 3 beacons available, take the 3 closest
    LocalizedBeaconData beacon1Data = beaconData[0];
    LocalizedBeaconData beacon2Data = beaconData[1];
    LocalizedBeaconData beacon3Data = beaconData[2];
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



class LocalizedBeaconData {

  LocalizedBeacon beacon;
  double distance;

  LocalizedBeaconData(this.beacon, this.distance);

  LocalizedBeaconData.fromBeacon(this.beacon);


}
