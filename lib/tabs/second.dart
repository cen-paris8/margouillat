import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';


//import '../widgets/drawer.dart';


class SecondTab extends StatefulWidget {
  static const String route = '/';
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<SecondTab> {
  static const String route = '/';
  double lat;
  double long;
  double latICGoogle;
  double longICGoogle;
  LatLng swboundaryGoo;
  LatLng neboundaryGoo;

  LocationData _startLocation;
  LocationData _currentLocation;

StreamSubscription<LocationData> _locationSubscription;

  Location _locationService  = new Location();
  bool _permission = false;
  String error;

  bool currentWidget = true;


  @override
  void initState() {
    super.initState();

    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  dynamic initPlatformState() async {
    print('passe dans init');

    await _locationService.changeSettings(accuracy: LocationAccuracy.HIGH, interval: 1000);
    
    LocationData location;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      var serviceStatus = await _locationService.serviceEnabled();
      print('Service status: $serviceStatus');
      if (serviceStatus) {
        print('wait for permission');
        _permission = await _locationService.requestPermission();
        print('Permission: $_permission');
        if (_permission) {
          location = await _locationService.getLocation();
          print('location init: $location.toString()');

            await _locationService.changeSettings(accuracy: LocationAccuracy.BALANCED, interval: 1000);
          _locationSubscription = _locationService.onLocationChanged().listen((LocationData result) async {
            
            if(mounted){
              setState(() {
                _currentLocation = result;
              });
            }
            print('_currentLocation: $_currentLocation');
          });
        }
      } else {
        var serviceStatusResult = await _locationService.requestService();
        print('Service status activated after request: $serviceStatusResult');
        if(serviceStatusResult){
          initPlatformState();
        }
      }
    } on PlatformException catch (e) {
      print(e);
      if (e.code == 'PERMISSION_DENIED') {
        error = e.message;
      } else if (e.code == 'SERVICE_STATUS_ERROR') {
        error = e.message;
      }
      location = null;
    }

    setState(() {
        _startLocation = location;
    });
    

  }

  @override
  Widget build(BuildContext context) {
    //lat = _currentLocation != null ? _currentLocation.latitude: latInit;
    //long = _currentLocation != null ? _currentLocation.longitude: longInit;
    lat = _currentLocation != null ? _currentLocation.latitude : latICGoogle;
    long = _currentLocation != null ? _currentLocation.longitude : longICGoogle;
    latICGoogle = 5.376037;
    longICGoogle = -3.993089;
    swboundaryGoo = LatLng(5.376010, -3.993148);
    neboundaryGoo = LatLng(5.376119, -3.993086);

    var markers = <Marker>[
      Marker(
        width: MediaQuery.of(context).size.width*0.8, //400.0,
        height: MediaQuery.of(context).size.height*0.8, //400.0,
        point: LatLng(latICGoogle, longICGoogle),
        builder: (ctx) => Container(
              child: Image.asset(
                'assets/images/cerco.png',
              ),
            ),
      ),
      Marker(
        width: 80.0,
        height: 80.0,
        point: LatLng(
                _currentLocation != null ? _currentLocation.latitude : latICGoogle, 
                _currentLocation != null ? _currentLocation.longitude : longICGoogle),
        builder: (ctx) => Container(
              child: Icon(Icons.my_location), //FlutterLogo(),
            ),
      ),
      Marker(
        width: 80.0,
        height: 80.0,
        point: LatLng(latICGoogle+0.000070, longICGoogle-0.000020),
        builder: (ctx) => Container(
              child: Icon(Icons.location_on, color: Colors.red),
            ),
      ),
      Marker(
        width: 80.0,
        height: 80.0,
        point: LatLng(latICGoogle-0.000030, longICGoogle+0.000030),
        builder: (ctx) => Container(
              child: Icon(Icons.location_on, color: Colors.red),
            ),
      ),
      Marker(
        width: 80.0,
        height: 80.0,
        point: LatLng(5.3760435, -3.9930153),
        builder: (ctx) => Container(
              child: Icon(Icons.toys, color: Colors.pink),
            ),
      ),
    ];

    return Scaffold(
      // appBar: AppBar(title: Text('Home')),
      //drawer: buildDrawer(context, route),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            /*Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
              //child: Text('This is a map that is showing (51.5, -0.9).'),
              child: Text('Titre message\n'),
            ),
            */
            /*
            Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
              //child: Text('This is a map that is showing (51.5, -0.9).'),
              child: Text(_startLocation != null
                  ? 'Start location: ${_startLocation.latitude} & ${_startLocation.longitude}\n'
                  : 'Error: $error\n'),
              ),
              
            Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
              //child: Text('This is a map that is showing (51.5, -0.9).'),
              child: Text(_currentLocation != null
                ? 'Continuous location: \nlat: ${_currentLocation.latitude} & long: ${_currentLocation.longitude} \nalt: ${_currentLocation.altitude}m\n'
                : 'Error: $error\n', textAlign: TextAlign.center),
              ),
            */
            Flexible(
              child: FlutterMap(
                /*
                options: MapOptions(
                  center: LatLng(lat, long),//LatLng(51.5, -0.09),
                  zoom: 22.0,
                ),
                */
                options: MapOptions(
                  center: LatLng(
                      latICGoogle, longICGoogle), //LatLng(56.704173, 11.543808),
                  minZoom: 5.0,
                  maxZoom: 23.0,
                  zoom: 22.0,
                  swPanBoundary: swboundaryGoo, // LatLng(5.3760411, -3.9930455), //LatLng(56.6877, 11.5089),
                  nePanBoundary: neboundaryGoo, // LatLng(5.3760711, -3.9930110), //LatLng(56.7378, 11.6644),
                ),
                layers: [
                  TileLayerOptions(
                      //urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                      urlTemplate:
                          'https://api.tiles.mapbox.com/v4/mapbox.streets/{z}/{x}/{y}@2x.png?access_token=pk.eyJ1Ijoic2FuZG9rYSIsImEiOiJjanZmMXRqbmgwa2N4NDBwYWF6YmY1bHJtIn0.VmKJysskyfpQXiv3p2t2vQ',
                      //urlTemplate: 'https://api.mapbox.com/styles/v1/sandoka/{id}/wmts?access_token={accessToken}',

                      additionalOptions: {
                        'accessToken':
                            'pk.eyJ1Ijoic2FuZG9rYSIsImEiOiJjanZmMXRqbmgwa2N4NDBwYWF6YmY1bHJtIn0.VmKJysskyfpQXiv3p2t2vQ',
                        'id': 'mapbox.streets', //'cjvf1r8og0mhy1fmpdod3qppz',
                        // 'mapbox':'//styles/sandoka/cjvf1r8og0mhy1fmpdod3qppz'
                      },
                      subdomains: [
                        'a',
                        'b',
                        'c'
                      ]),
                  MarkerLayerOptions(markers: markers)
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
