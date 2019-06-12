import 'package:flutter/material.dart';
import 'package:using_bottom_nav_bar/models/step_model.dart';

class DebugStep extends StatelessWidget {

  final BaseStepModel model;

  DebugStep({this.model});

  List<Widget> get modelProperties {
    dynamic data = model.toJson;
    List<Widget> list = new List();
    for(var k in data.keys) {
      list.add(new Text("$k : ${data[k]}"));
    }
    return list;
  }

  List<Widget> buildDebugView() {
     List<Widget> list = this.modelProperties;
     list.insert(0, new Text('###### DEBUG #######'));
     return list;
  }

  @override
  Widget build(BuildContext context) {
    return new Card(
        color: Colors.white,
        elevation: 10.0,
        child: Container(
          height: 300.0,
          alignment: Alignment.centerLeft,
          child: Column(
            children: this.buildDebugView(),
            crossAxisAlignment: CrossAxisAlignment.start,
            textDirection: TextDirection.ltr,
            )
          /*
          child: Column(children: <Widget>
            [
              Expanded(
                child: Text('###### DEBUG #######')
                ),
              Expanded(
                child: Text(this.model.index.toString())
                ),
              Expanded(
                child: Text(this.model.title)
                ),
              Expanded( 
                child: Text(this.model.shortDescription)
                ),
              Expanded(
                child: Text(this.model.description)
                ),
              Expanded(
                child: Text(this.model.info)
                ),
              ],
            )*/
          )
        );
      } 
}