import 'dart:collection';
import 'dart:math';

import 'package:using_bottom_nav_bar/logic/data_filter1D.dart';

class MeanFilter1D implements DataFilter1D { 

  Queue<num> _signalValues = new Queue();
  int _queueSize = 10;

  MeanFilter1D(this._queueSize);

  void addSignalValue(double value) {
    if(_signalValues.length == _queueSize) {
      _signalValues.removeFirst();
    }
    _signalValues.addLast(value);
  }

  double _calculateMean() {
    if(_signalValues.isEmpty) {return 0;}
    if(_signalValues.length >= 5) {
      num mx = _signalValues.reduce(max);
      _signalValues.remove(mx);
      num mn = _signalValues.reduce(min);
      _signalValues.remove(mn);
    }
    num mean = _signalValues.reduce((a, b) => a + b) / _signalValues.length ;
    return mean;
  }

  double filter(double value) {
    this.addSignalValue(value);
    return _calculateMean();
  }

}