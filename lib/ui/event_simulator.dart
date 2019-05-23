import 'dart:io';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
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
            Expanded(
              child: TextField(
                controller: controller,
                maxLength: 20,
              )
            ),
            new Padding(padding: EdgeInsets.all(10.0)),
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
                new Padding(padding: EdgeInsets.all(5.0)),
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
            new Padding(padding: EdgeInsets.all(5.0)),
            Expanded(
              child: Text(_receivedEvent)
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