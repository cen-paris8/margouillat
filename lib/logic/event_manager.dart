import 'dart:async';

import 'package:using_bottom_nav_bar/logic/beacon_manager.dart';
import 'package:using_bottom_nav_bar/logic/position_manager.dart';

class EventManager {

  StreamController _uiEventsController = new StreamController.broadcast();
  StreamController _beaconEventsController = new StreamController.broadcast();
  StreamController _positionEventsController = new StreamController.broadcast();

  static final EventManager _instance =
      new EventManager._internal();

  factory EventManager() {
    return _instance;
  }

  EventManager._internal(){}

  void addUIEvent(String event) {
    _uiEventsController.add(event);
  }

  void addUIEventListener(Function callback){
    _uiEventsController.stream.listen(callback);
  }

  void addUIEventHandler(Function dataHandler){
    _uiEventsController.stream.listen((data) {
        print("DataReceived: "+data);
        dataHandler(data);
      }, 
      onDone: () {
        print("Task Done or Stream closed");
      }, 
      onError: (error) {
        print("Some Error");
      }
    );
  }


  void addBeaconEvent(RangingEvent event) {
    _beaconEventsController.add(event);
  }

  void addBeaconEventListener(Function callback){
    _beaconEventsController.stream.listen(callback);
  }

  void addBeaconEventHandler(Function dataHandler){
    _beaconEventsController.stream.listen((data) {
        print("Beacon event received");
        dataHandler(data);
      }, 
      onDone: () {
        print("Task Done or Stream closed");
      }, 
      onError: (error) {
        print("Some Error");
      }
    );
  }


  void addPositionEvent(PositionEvent event) {
    _positionEventsController.add(event);
  }

  void addPositionEventListener(Function callback){
    _positionEventsController.stream.listen(callback);
  }

  void addPositionEventHandler(Function dataHandler){
    _positionEventsController.stream.listen((data) {
        print("Position event received");
        dataHandler(data);
      }, 
      onDone: () {
        print("Task Done or Stream closed");
      }, 
      onError: (error) {
        print("Some Error");
      }
    );
  }

  Stream get positionStream { return _positionEventsController.stream; }

}

