import 'dart:math';

class MathHelper {

  static double calculateDistance(int txPower, double rssi) {
    if (rssi == 0) return -1.0; // if we cannot determine accuracy, return -1.
    double ratio = rssi * 1.0 / txPower;
    if (ratio < 1.0) 
      return pow(ratio,10);
    else 
      return  (0.89976) * pow(ratio,7.7095) + 0.111;
  }

  double calculateDistance01(int txPower, int rssi) {
    int n = 2; //  the signal propagation exponent, usually 2 for indoor applications
    double exponent = -(rssi-txPower)/(10*n);
    double distance = pow(10, exponent);
    return distance;
  }

  static String format(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 2);
  }

}