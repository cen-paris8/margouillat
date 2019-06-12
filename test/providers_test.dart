import 'dart:developer';
import 'package:rxdart/rxdart.dart';
import 'package:test/test.dart';
import 'package:using_bottom_nav_bar/logic/beacon_manager.dart';
import 'package:using_bottom_nav_bar/logic/position_manager.dart';
import 'package:using_bottom_nav_bar/logic/virtual_map.dart';
import 'package:using_bottom_nav_bar/models/position.dart';
import 'package:using_bottom_nav_bar/repositories/beacon_repository.dart';
import '../lib/models/game_model.dart';
import '../lib/repositories/game_repository.dart';

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
    List<BeaconAnchor> beacons = _repository.getBeaconAnchors("dummy");
    List<BeaconAnchorData> beaconsData = new List<BeaconAnchorData>();
    BeaconAnchorData lbd1 = BeaconAnchorData.fromBeacon(beacons[0]);
    BeaconAnchorData lbd2 = BeaconAnchorData.fromBeacon(beacons[1]);
    BeaconAnchorData lbd3 = BeaconAnchorData.fromBeacon(beacons[2]);
    beaconsData.add(lbd1);
    beaconsData.add(lbd2);
    beaconsData.add(lbd3);
    Position expectedPosition = Position.origin();
    for(Position p in testPositions) {
      expectedPosition = p;
      num d1 = expectedPosition.distanceTo(lbd1.beacon.position) + 1;
      lbd1.addSDistance(d1);
      num d2 = expectedPosition.distanceTo(lbd2.beacon.position) - 2;
      lbd1.addSDistance(d2);
      num d3 = expectedPosition.distanceTo(lbd3.beacon.position) + 1;
      lbd1.addSDistance(d3);
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