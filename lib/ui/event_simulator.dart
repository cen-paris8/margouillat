import 'package:flutter/material.dart';
import 'package:flutter_beacon/flutter_beacon.dart';
import 'package:using_bottom_nav_bar/logic/beacon_manager.dart';
import '../logic/event_manager.dart';

class EventSimulator extends StatefulWidget {

  @override
  _EventSimulatorState createState() => _EventSimulatorState();

  EventSimulator({Key key})
    : super(key: key);

}

class _EventSimulatorState extends State<EventSimulator> {

  final TextEditingController controller = TextEditingController();
  final EventManager _eventManager = EventManager();
  String _receivedEvent = 'No event received';

  void _sendEvent(String value) {
    print('Sending event: $value');
    _eventManager.addUIEvent(value);
  }

  void _sendBeaconEvent(String value) {
    print('Sending beacon event: $value');
    RangingEvent be = new RangingEvent();
    be.region = new Region(identifier: 'test');
    Beacon b = new Beacon();
    be.beacons.add(new BeaconModel.fromBeacon(b));
    _eventManager.addBeaconEvent(be);
  }

  void _handleEvent(String data){
    _receivedEvent = data;    
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      _sendEvent(controller.text);
    });
    _eventManager.addUIEventHandler((data) => {
      _handleEvent(data)
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Card(
      //color: Colors.white,
      color: Colors.amber[600],
      elevation: 10.0,
      child: Container(
        //height: 200.0,
        //width: 100.0,
        alignment: Alignment.bottomCenter,
        constraints:
          BoxConstraints.expand(height: 100.0),
        child: Column (
          children: <Widget>[
            /*
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: controller,
                    maxLength: 20,
                  )
                )
              ]
            ),
            */
            Row(
              children: <Widget>[
                Expanded(
                  child: MaterialButton(
                    height: 20.0,
                    minWidth: 80.0,
                    color: Colors.blueGrey,
                    onPressed: () => _sendEvent('1'),
                    child: new Text('Send event 1',
                      style: new TextStyle(
                      fontSize: 12.0,
                      color: Colors.white
                      ),
                    ),
                  )
                ),
                Expanded(
                  child: MaterialButton(
                    height: 20.0,
                    minWidth: 80.0,
                    color: Colors.blueGrey,
                    onPressed: () => _sendEvent('2'),
                    child: new Text('Send event 2',
                      style: new TextStyle(
                      fontSize: 12.0,
                      color: Colors.white
                      ),
                    ),
                  )
                )
              ]
            ),
            Row(
              children: <Widget>[
                Expanded(
                child: Text(_receivedEvent)
                ),
                Expanded(
                  child: MaterialButton(
                    height: 20.0,
                    minWidth: 80.0,
                    color: Colors.blueGrey,
                    onPressed: () => _sendBeaconEvent('Beacon'),
                    child: new Text('Send beacon event',
                      style: new TextStyle(
                      fontSize: 12.0,
                      color: Colors.white
                      ),
                    ),
                  )
                ),
              ]
            )
          ]
        )
      )
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

}