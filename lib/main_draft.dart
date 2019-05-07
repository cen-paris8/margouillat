import 'package:flutter/material.dart';

// void main() => runApp(FirstScreen());
void main() {
  runApp(MaterialApp(
    title: 'Named Routes Demo',
    // Start the app with the "/" named route. In our case, the app will start
    // on the FirstScreen Widget
    initialRoute: '/',
    routes: {
      // When we navigate to the "/" route, build the FirstScreen Widget
      '/': (context) => MyApp(),
      // When we navigate to the "/second" route, build the SecondScreen Widget
      '/second': (context) => SecondScreen(),
    },
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Widget titleSection = Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            /*1*/
            
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                /*2*/
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  
                  child: Text(
                    'Bonjour !',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                ),
                Text(
                  'Je me présente, je m\'appelle Regina, c\'est moi qui vais vous guider pendant votre aventure',
                  style: TextStyle(
                    //color: Colors.grey[500],
                  ),
                ),
                
              ],
            ),
            
          ),
          /*3*/
            Image.asset(
              'images/regina.png',
              width: 150,
              height: 100,
              //fit: BoxFit.cover,
            ),
            
            
        ],
      ),
    );

    Widget textSection = Container(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Text(
        'Vous entrez dans le Palais du Grand Mazary, grace à votre passe vous avez pu pénétrer dans sa demeure.'
            'Vous avez une heure pour cumuler un maximum de points et résoudre toutes les énigmes. '
            'Vous pouvez aller où bon vous semble, mais attention aux gardes, '
            'ils n\'aiment pas qu\'on fuinent dans leurs affaires '
            'Ne vous laissez pas distraire, le temps presse',
        softWrap: true,
      ),
    );
    
    
    Widget nextSection = Container(
      margin: const EdgeInsets.only(top: 32.0),
      child: RaisedButton(
          child: Text('Launch screen'),
          onPressed: () {
            // Navigate to the second screen using a named route
            Navigator.pushNamed(context, '/second');
          },
      ),    );
    
    
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blueGrey,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Cerco Game'),
        ),
        body: ListView(
          children: [
            titleSection,
            textSection,
            nextSection,
          ],
        ),
    ),
    );
  }
}


class SecondScreen extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

      Widget nextSection = Container(
      child: RaisedButton(
          child: Text('Go Back'),
          onPressed: () {
            // Navigate to the second screen using a named route
            Navigator.pop(context);
          },
      ),
    );
    
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blueGrey,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Cerco Game'),
        ),
        body: ListView(
          children: [
            Image.asset(
              'images/plan.png',
              width: 300,
              height: 550,
              //fit: BoxFit.cover,
            ),
            nextSection,
          ],
        ),
    ),
    );
  }

  
}
