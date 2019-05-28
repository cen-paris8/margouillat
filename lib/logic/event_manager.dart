import 'dart:async';

class EventManager {

  StreamController _uiEventsController = new StreamController.broadcast();
  StreamController _beaconEventsController = new StreamController.broadcast();

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

  void addBeaconEvent(var event) {
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

  //Stream get uiStream => _uiEventsController.stream;

}

