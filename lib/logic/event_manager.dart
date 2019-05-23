import 'dart:async';

class EventManager {

  List<StreamController> controllers = new List<StreamController>();

  StreamController uiEventsController = new StreamController.broadcast();

  static final EventManager _instance =
      new EventManager._internal();

  factory EventManager() {
    return _instance;
  }

  EventManager._internal(){}

  void addUIEvent(String event) {
    uiEventsController.add(event);
  }

  void addUIEventListener(Function callback){
    uiEventsController.stream.listen(callback);
  }

  void addUIEventHandler(Function dataHandler){
    uiEventsController.stream.listen((data) {
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

  //Stream get uiStream => uiEventsController.stream;

}