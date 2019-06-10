import 'dart:developer';
import 'dart:io';
import 'dart:math';


import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';
import 'package:test/test.dart';
import 'package:using_bottom_nav_bar/logic/beacon_manager.dart';
import 'package:using_bottom_nav_bar/logic/position_manager.dart';
import 'package:using_bottom_nav_bar/models/beacon_model.dart';
import 'package:using_bottom_nav_bar/repositories/beacon_repository.dart';
import '../lib/models/game_model.dart';
import '../lib/providers/firebasestorage_provider.dart';
import '../lib/providers/firestore_provider.dart';
import '../lib/providers/localstorage_provider.dart';
import '../lib/repositories/game_repository.dart';
import 'package:path_provider/path_provider.dart' as PathProvider;

void main() {

  test('Get game data from firestore', () async {
    final GameRepository _repository = new GameRepository();
    Observable<GameModel> oGame = _repository.getGame('rBnjvYj5K');
    GameModel game = await oGame.single;
    debugger();
    print(game);
    expect(game, isNotNull);
  });

  final List<Position> testPositions = List.from(
    [
      new Position(1,5),
      new Position(4,5),
      new Position(8,1),
      new Position(7,3),
    ]
  );

  test('Get current location', () {
    final BeaconRepository _repository = new BeaconRepository();
    PositioningManager pManager = PositioningManager();
    List<LocalizedBeacon> beacons = _repository.getLocalizedBeacons("dummy");
    List<LocalizedBeaconData> beaconsData = new List<LocalizedBeaconData>();
    LocalizedBeaconData lbd1 = LocalizedBeaconData.fromBeacon(beacons[0]);
    LocalizedBeaconData lbd2 = LocalizedBeaconData.fromBeacon(beacons[1]);
    LocalizedBeaconData lbd3 = LocalizedBeaconData.fromBeacon(beacons[2]);
    beaconsData.add(lbd1);
    beaconsData.add(lbd2);
    beaconsData.add(lbd3);
    Position expectedPosition = Position.origin();
    for(Position p in testPositions) {
      expectedPosition = p;
      lbd1.distance = expectedPosition.distanceTo(lbd1.beacon.position) + 1;
      lbd2.distance = expectedPosition.distanceTo(lbd2.beacon.position) - 2;
      lbd3.distance = expectedPosition.distanceTo(lbd3.beacon.position) + 1;
      Position currentPosition = pManager.calculatePosition(beaconsData);
      expect(currentPosition, isNotNull);  
      num distanceExpectedToCurent = expectedPosition.distanceTo(currentPosition);
      print(distanceExpectedToCurent);
      num distanceTolerance = 0.5;
      expect(distanceExpectedToCurent.abs(), lessThan(distanceTolerance));
    }
  });

   test('Get current location', () {
     BeaconManager bManager = BeaconManager();
     
   });



}