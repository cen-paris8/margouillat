import 'dart:math';

import 'package:test/test.dart';
import 'package:using_bottom_nav_bar/logic/kalman_filter1D.dart';
import 'package:using_bottom_nav_bar/logic/math_helper.dart';
import 'package:using_bottom_nav_bar/logic/mean_filter1D.dart';
import 'package:using_bottom_nav_bar/logic/median_filter1D.dart';


void main() {

  
  test('Kalman filter', () {

    List<num> realData = List.filled(30, 1).map(
      (i) => pow(1.1, i) 
    ).toList();

    List<num> noisyData = realData.map(
      (v) => v + Random.secure().nextInt(20)
    ).toList();

    var kalmanFilter = new KalmanFilter1D(0.01, 20);

    num filteredData = 0;
    for(num data in noisyData) {
      filteredData = kalmanFilter.filter(data, 0);
    }

    expect(kalmanFilter, isNotNull);
     
  });

  test('Distance calculation with filter', () {
    const distances = [0.25, 0.5, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 14, 16, 18, 20, 25, 30, 40];
    List<double> rssi = List<double>.from([-41.0, -43.0,-49.0,-65.0,-58.0,-57.0,-67.0,-67.0,-77.0,-70.0,-69.0,-75.0,-72.0,-72.0,-78.0,-83.0,-81.0,-81.0,-75.0,-83.0]);
    int txPower = -51;
    KalmanFilter1D kalmanFilter = new KalmanFilter1D(1, 10);
    MeanFilter1D meanFilter = new MeanFilter1D(5);
    MedianFilter1D medianFilter = new MedianFilter1D(5);
    //kalmanFilter.B = -1;
    int i = 0;
    for(double rawSignal in rssi) {
      double rawDistance = MathHelper.calculateDistance(txPower, rawSignal);
      double kFilteredSignal = kalmanFilter.filter(rawSignal, 1);
      double kFilteredDistance = MathHelper.calculateDistance(txPower, kFilteredSignal);
      double mFilteredSignal = meanFilter.filter(rawSignal);
      double mFilteredDistance = MathHelper.calculateDistance(txPower, mFilteredSignal);
      double medFilteredSignal = meanFilter.filter(rawSignal);
      double medFilteredDistance = MathHelper.calculateDistance(txPower, medFilteredSignal);
      print("${distances[i]};$rawSignal; ${MathHelper.format(rawDistance)};${MathHelper.format(kFilteredSignal)};${MathHelper.format(kFilteredDistance)};${MathHelper.format(mFilteredSignal)};${MathHelper.format(mFilteredDistance)};${MathHelper.format(medFilteredSignal)};${MathHelper.format(medFilteredDistance)}");
      //double filteredDistance =  kalmanFilter.filter(rawDistance);
      //print("${distances[i]};${s};${MathHelper.format(rawDistance)};${MathHelper.format(filteredDistance)}");
      i++;
    }

    expect(kalmanFilter, isNotNull);
  });

}
