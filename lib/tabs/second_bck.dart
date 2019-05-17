import 'package:flutter/material.dart';

class SecondTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new ListView.builder(
          itemCount: 4,
          itemBuilder: (BuildContext context, int index) {
            return new Card(
              child: new Container(
                padding: new EdgeInsets.all(20.0),
                child: new Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        child: Image.asset(
                          'assets/images/map$index.jpg',
                          //width: 150,
                          //height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );

    /*
    return new Scaffold(
      backgroundColor: Colors.brown,
      body: new Container(
        child: new Center(
          child: new Column(
            // center the children
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(child: Image.asset(
                  'assets/images/map.jpg',
                  //width: 150,
                  //height: 100,
                  fit: BoxFit.cover,
                ),)
            ],
          ),
        ),
      ),
    );
    */
  }
}
