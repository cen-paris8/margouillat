import 'package:using_bottom_nav_bar/logic/virtual_map.dart';
import 'package:using_bottom_nav_bar/providers/firestore_provider.dart';

class BeaconRepository {

  final FirestoreProvider _firestoreProvider = new FirestoreProvider();

  // TODO : remove, only for test
  List<BeaconAnchor> simulatedBeacons = List.from(
    [
      new BeaconAnchor(1.0, 4.0, "4d6fc88b-be75-6698-da48-6866a36ec78e"), // 1
      new BeaconAnchor(5.0, 13.0, "644f76f7-6a52-42bc-e911-5e8c56441796"), // 2
      new BeaconAnchor(9.0, 0.0, "644f76f7-6a52-42bc-e911-5e8c6279c1a0"), // 3
    ]
  );

  List<BeaconAnchor> getBeaconAnchors(String gamePlayId) {
    return this.simulatedBeacons;
  }

} 