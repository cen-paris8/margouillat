import 'package:using_bottom_nav_bar/models/beacon_model.dart';
import 'package:using_bottom_nav_bar/providers/firestore_provider.dart';

class BeaconRepository {

  final FirestoreProvider _firestoreProvider = new FirestoreProvider();

  // TODO : remove, only for test
  final List<LocalizedBeacon> simulatedBeacons = List.from(
    [
      new LocalizedBeacon(new Position(2, 2), "4d6fc88b-be75-6698-da48-6866-a36ec78e"),
      new LocalizedBeacon(new Position(5, 5), "tata"),
      new LocalizedBeacon(new Position(2, 8), "titi"),
    ]
  );

  List<LocalizedBeacon> getLocalizedBeacons(String gamePlayId) {
    return this.simulatedBeacons;
  }

} 