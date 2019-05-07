import 'package:flutter/material.dart';

//void main() => runApp(ThirdTab());
/*
class ThirdTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.orange,
      body: new Container(
        child: new Center(
          child: new Column(
            // center the children
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Icon(
                Icons.airport_shuttle,
                size: 160.0,
                color: Colors.white,
              ),
              new Text(
                "Third Tab",
                style: new TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
*/
class ThirdTab extends StatelessWidget {

  @override
   Widget build(BuildContext context) {

    return MaterialApp(

      title: 'Flutter Demo',

      theme: ThemeData(

        primarySwatch: Colors.blue,

      ),

      home: MyHomePage(title: 'Drop Down Field Method Demo'),

    );

  }

}

class MyHomePage extends StatefulWidget {

  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override

  _MyHomePageState createState() => _MyHomePageState();

}

class _MyHomePageState extends State {

//lists that are used to build the drop down menus attached to fields

  List _colors = ['', 'red', 'green', 'blue', 'orange'];

  List _dogs = ['', 'muff', 'rover'];

  List _people = ['', 'mum', 'dad', 'sister', 'brother'];

  //one list that holds all the selected results for the three drop down menus

  var resultsList = new List.filled(3, '');

  @override

  void initState() {

    //set the intial feild value

    resultsList[0] = 'red'; //this would be set from a database field

    resultsList[1] = 'muff'; //this would be set from a database field

    resultsList[2] = 'mum'; //this would be set from a database field

    return super.initState();

  }

//method that builds and updates the drop down menu

  _fieldDropDown(List theList, int resultPosition, var dbField) {

    return new FormField(

      builder: (FormFieldState state) {

        return InputDecorator(

          decoration: InputDecoration(),

          child: new DropdownButtonHideUnderline(

            child: new DropdownButton(

              value: this.resultsList[resultPosition],

              isDense: true,

              onChanged: (dynamic newValue) {

                setState(() {

                  this.resultsList[resultPosition] = newValue;

                  state.didChange(newValue);

                  print(

                      'The List result = ' + this.resultsList[resultPosition]);

                  //write newValue to a database field, which can be used in the override init to set the field originally

                });

              },
              
              items: theList.map((dynamic value) {

                return new DropdownMenuItem(

                  value: value,

                  child: new Text(value),

                );

              }).toList(),

            ),

          ),

        );

      },

    );

  }

  @override

  Widget build(BuildContext context) {
    
    return new Scaffold(

      /*
      appBar: new AppBar(

        //title: new Text(widget.title),
        title: new Text("fix title"),

      ),
      */

      body: new SafeArea(

          top: false,

          bottom: false,

          child: new Form(

              //key: _formKey,

              autovalidate: true,

              child: new ListView(

                padding: const EdgeInsets.symmetric(horizontal: 16.0),

                children: [

            //create some fields, hand in the list

           _fieldDropDown(_colors, 0, 'colorDBfield'),

           _fieldDropDown(_dogs, 1, 'dogDBfield'),

           _fieldDropDown(_people, 2, 'peopleDBfield'),
              ],
         ))),
    );
  }
}