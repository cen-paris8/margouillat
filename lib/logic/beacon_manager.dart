import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_beacon/flutter_beacon.dart';
import 'package:using_bottom_nav_bar/logic/event_manager.dart';

class BeaconManager {

  StreamController _beaconEventsController = new StreamController.broadcast();
  StreamSubscription<RangingResult> _streamRanging;
  final _regionBeacons = <Region, List<Beacon>>{};
  final _beacons = <Beacon>[];
  final EventManager _eventManager = EventManager();

  static final BeaconManager _instance =
      new BeaconManager._internal();

  factory BeaconManager() {
    return _instance;
  }

  BeaconManager._internal(){
    this._init();
  }

  void _init() async {
    try {
      await flutterBeacon.initializeScanning;
      print('Beacon scanner initialized');
    } on PlatformException catch (e) {
      print("Flutter beacon initialization failed.");
      print(e);
    }

    final regions = <Region>[];

    if (Platform.isIOS) {
      regions.add(
        Region(
            identifier: 'Cubeacon',
            proximityUUID: 'CB10023F-A318-3394-4199-A8730C7C1AEC'),
      );
      regions.add(Region(
          identifier: 'Apple Airlocate',
          proximityUUID: 'E2C56DB5-DFFB-48D2-B060-D0F5A71096E0'));
    } else {
      regions.add(Region(
        identifier: 'com.beacon'
        //"8ec76ea3-6668-48da-9866-75be8bc86f4d"
        //proximityUUID: "4d6fc88b-be75-6698-da48-6866-a36ec78e"
        ));
    }

    Stream<RangingResult> beaconEventStream = flutterBeacon.ranging(regions);
    _beaconEventsController.addStream(beaconEventStream);
    _beaconEventsController.stream.listen((result) {
      _processBeaconEventsStream(result);
    });
  }

  void _processBeaconEventsStream(var event) {
    if (event != null) {
        _regionBeacons[event.region] = event.beacons;
        _beacons.clear();
        _regionBeacons.values.forEach((list) {
        _beacons.addAll(list);
        _beacons.sort(_compareParameters);
      });
    //print('Processing beacon event : $event');
    RangingEvent rangingEvent = RangingEvent.fromRangingResult(event);
    print(rangingEvent);
    if(rangingEvent.beacons.length > 0) {
      _eventManager.addBeaconEvent(rangingEvent);
      }
    }
  }

  int _compareParameters(Beacon a, Beacon b) {
    int compare = a.proximityUUID.compareTo(b.proximityUUID);
    if (compare == 0) {
      compare = a.major.compareTo(b.major);
    }
    if (compare == 0) {
      compare = a.minor.compareTo(b.minor);
    }
    return compare;
  }

  // TODO : check if dispose is necessary

}

class RangingEvent {

  Region region;
  List<BeaconModel> beacons;

  RangingEvent.fromRangingResult(RangingResult rangingResult) {
    this.region = rangingResult.region;
    this.beacons =  new List();
    print('${rangingResult.beacons.length} beacons listed.');
    for(Beacon b in rangingResult.beacons) {
      BeaconModel bm = BeaconModel.fromBeacon(b);
      this.beacons.add(bm);
    }
  }

  @override
  String toString() {
    return 'RangingResult{"region": ${json.encode(region.toJson)} , "beacons": ${json.encode(BeaconModel.beaconModelArrayToJson(beacons))}';
}

}


class BeaconModel {

  /// The proximity UUID of beacon.
  String proximityUUID;

  /// The mac address of beacon.
  ///
  /// From iOS this value will be null
  String macAddress;

  /// The major value of beacon.
  int major;

  /// The minor value of beacon.
  int minor;

  /// The rssi value of beacon.
  int rssi;

  /// The transmission power of beacon.
  ///
  /// From iOS this value will be null
  int txPower;

  /// The accuracy of distance of beacon in meter.
  double accuracy;

  /// The proximity of beacon.
  Proximity proximity;

  BeaconModel.fromBeacon(Beacon b) {
    this.proximityUUID = b.proximityUUID;
    this.macAddress = b.macAddress;
    this.major = b.major;
    this.minor = b.minor;
    this.rssi = b.rssi;
    this.accuracy = b.accuracy == double.infinity ? this.getAccuracyWithDefaultMethod() : b.accuracy;
    this.txPower = b.txPower;
    this.proximity =  b.accuracy == double.infinity ? this.getProximityWithDefaultMethod() : b.proximity; 
  }

  // TODO : remove
  static const distances = [0.25, 0.5, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 14, 16, 18, 20, 25, 30, 40];
  static const defaultRSSIMap = [-45, -47, -50, -55, -60, -65, -70, -75, -80, -85, -90, -100, -110, -120, -130, -140, -160, -200, -220, -250];
  double getAccuracyWithDefaultMethod() {
    double newAccuracy = (this.rssi.abs()-45) * 0.2;
    return newAccuracy.abs();
  }
  Proximity getProximityWithDefaultMethod() {
    print(this.accuracy);
    //if (proximity != null) { return proximity; }
    if (accuracy == 0.0) { return Proximity.unknown; }
    if (accuracy <= 0.5) { return Proximity.immediate; }
    if (accuracy < 3.0) { return Proximity.near; }
    return Proximity.far;
  }

  dynamic get toJson {
    final map = <String, dynamic>{
      'proximityUUID': proximityUUID,
      'major': major,
      'minor': minor,
      'rssi': rssi ?? -1,
      'accuracy': accuracy,
      'proximity': proximity.toString() 
    };

    if (Platform.isAndroid) {
      map['txPower'] = txPower ?? -1;
      map['macAddress'] = macAddress ?? "";
    }

    return map;
  }

    static dynamic beaconModelArrayToJson(List<BeaconModel> beacons) {
    return beacons.map((beacon) {
      return beacon.toJson;
    }).toList();
}

}