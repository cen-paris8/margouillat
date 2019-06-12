import 'dart:collection';

import 'package:using_bottom_nav_bar/logic/data_filter1D.dart';

class MedianFilter1D  implements DataFilter1D  { 

  Queue<num> _signalValues = new Queue();
  int _queueSize = 10;

  MedianFilter1D(this._queueSize);

  void addSignalValue(double value) {
    if(_signalValues.length == _queueSize) {
      _signalValues.removeFirst();
    }
    _signalValues.addLast(value);
  }

  double _getMedian() {
    double median;
    if(_signalValues.isEmpty) {return 0;}
    _signalValues.toList().sort();
    double midSize = _signalValues.length/2;
    int midIndex = midSize.round()-1;
    if (_signalValues.length % 2 == 0) // even
        median = (_signalValues.elementAt(midIndex) + _signalValues.elementAt(midIndex + 1))/2;
    else // odds
        median = _signalValues.elementAt(midIndex);
    return median;
  }

  double filter(double value) {
    this.addSignalValue(value);
    return _getMedian();
  }

}