import 'package:flutter/material.dart';
import 'package:using_bottom_nav_bar/tabs/first.dart';
import 'package:using_bottom_nav_bar/tabs/second.dart';
import 'package:using_bottom_nav_bar/tabs/third.dart';

void main() {
  runApp(new MaterialApp(
      // Title
      title: "Using Tabs",
      // Home
      home: new MyHome()));
}

class MyHome extends StatefulWidget {
  @override
  MyHomeState createState() => new MyHomeState();
}

// SingleTickerProviderStateMixin is used for animation
class MyHomeState extends State<MyHome> with SingleTickerProviderStateMixin {
  // Create a tab controller
  TabController controller;

  @override
  void initState() {
    super.initState();

    // Initialize the Tab Controller
    controller = new TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    // Dispose of the Tab Controller
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      // Appbar
      appBar: new AppBar(
        // Title
        title: new Text("Cerco Game"),
        // Set the background color of the App Bar
        backgroundColor: Colors.teal,
      ),
      // Set the TabBar view as the body of the Scaffold
      body: new TabBarView(
        // Add tabs as widgets
        children: <Widget>[new FirstTab(), new SecondTab(), new ThirdTab()],
        // set the controller
        controller: controller,
      ),
      // Set the bottom navigation bar
      bottomNavigationBar: new Material(
        // set the color of the bottom navigation bar
        color: Colors.blueGrey,
        // set the tab bar as the child of bottom navigation bar
        child: new TabBar(
          tabs: <Tab>[
            new Tab(
              // set icon to the tab
              icon: new Icon(Icons.home),
            ),
            new Tab(
              icon: new Icon(Icons.map),
            ),
            new Tab(
              icon: new Icon(Icons.info),
            ),
          ],
          // setup the controller
          controller: controller,
        ),
      ),
    );
  }
}
