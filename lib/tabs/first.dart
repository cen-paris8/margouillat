import 'package:flutter/material.dart';

class FirstTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget titleSection = Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            /*1*/

            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                /*2*/
                Image.asset(
                  'assets/images/regina.png',
                  //width: 150,
                  //height: 100,
                  //fit: BoxFit.cover,
                ),
                Container(
                  //padding: const EdgeInsets.only(bottom: 8),
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Bonjour !',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                Text(
                  'Je me présente, je m\'appelle Regina, c\'est moi qui vais vous guider pendant votre aventure',
                  style: TextStyle(
                      //color: Colors.grey[500],
                      fontSize: 20.0,
                      ),
                ),
              ],
            ),
          ),
          /*3*/
        ],
      ),
    );
    return new Scaffold(
      backgroundColor: Colors.white24,
      body: new Container(
        child: new Center(
          child: new Column(
              // center the children
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                titleSection,
              ]),
        ),
      ),
    );
  }
}
