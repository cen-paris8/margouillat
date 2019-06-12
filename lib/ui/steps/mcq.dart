import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import '../../models/step_model.dart';

class MCQWidget extends StatefulWidget {

  MCQWidget({Key key, this.model})
      : super(key: key);

  final MCQStepModel model;

  @override
  _MCQWidgetState createState() => _MCQWidgetState();
  
}


class _MCQWidgetState extends State<MCQWidget> {

 List<bool> _goodButtons = List.from([false, false, false, false]);
 List<bool> _activeButtons = List.from([true, true, true, true]);
 List<bool> _errorMessages = new List<bool>();
  
  Future<void> _ackModal(BuildContext context, String msg) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          //title: Text('Résultat'),
          content: Text(msg),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _handleButtonPressed(int index) {
    MCQStepModel model = widget.model;
    int errorMsgIndex = _activeButtons.where((e) => !e).length;
    String msg = model.errMsg[errorMsgIndex];
    if(model.correctAnswser == index)
      msg = model.winMsg;
    _ackModal(context, msg).then(
      (value) => setState(() {
        _goodButtons[index] = model.correctAnswser == index;
        _activeButtons[index] = false;
      })
    );
  }

  @override
  Widget build(BuildContext context) {
    MCQStepModel model = widget.model;
    return new Container(
        margin: const EdgeInsets.all(10.0),
        alignment: Alignment.topCenter,
        child: new Column(
          children: <Widget>[
            new Padding(padding: EdgeInsets.all(12.0)),

            new Container(
              alignment: Alignment.centerRight,
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[

                  new Text("${model.title}",
                    style: new TextStyle(
                        fontSize: 22.0
                    ),),
                ],
              ),
            ),

            new Padding(padding: EdgeInsets.all(10.0)),

            new Text(model.description,
              style: new TextStyle(
                fontSize: 12.0,
              ),),

            new Padding(padding: EdgeInsets.all(10.0)),

            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[

                //button 1
                new QuizChoiceButton(
                  index: 0,
                  text: model.choices[0],
                  isGood: _goodButtons[0],
                  isActive: _activeButtons[0],
                  onBtnPressed: () {   
                    _handleButtonPressed(0);
                  }
                ),

                //button 2
                new QuizChoiceButton(
                  index: 1,
                  text: model.choices[1],
                  isGood: _goodButtons[1],
                  isActive: _activeButtons[1],
                  onBtnPressed: () {   
                    _handleButtonPressed(1);
                  }
                ),
              ],
            ),

            new Padding(padding: EdgeInsets.all(10.0)),

            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[

                //button 3
                new QuizChoiceButton(
                  index: 2,
                  text: model.choices[2],
                  isGood: _goodButtons[2],
                  isActive: _activeButtons[2],
                  onBtnPressed: () {   
                    _handleButtonPressed(2);
                  }
                ),

                //button 4
                new QuizChoiceButton(
                  index: 0,
                  text: model.choices[3],
                  isGood: _goodButtons[3],
                  isActive: _activeButtons[3],
                  onBtnPressed: () {   
                    _handleButtonPressed(3);
                  }
                ),

              ],
            ),
          ],
        ),
    );
  }
}


class QuizChoiceButton extends StatefulWidget {

  QuizChoiceButton({Key key, this.index, this.text, this.onBtnPressed, this.isGood, this.isActive})
    : super(key: key);

  final int index;
  final String text;
  final VoidFunc onBtnPressed;
  final bool isGood;
  final bool isActive;
  //Function(BuildContext, int) onPressed;

  @override
  _QuizChoiceButtonState createState() => _QuizChoiceButtonState();
  
}

class _QuizChoiceButtonState extends State<QuizChoiceButton> {
 
  void _onPressed() {
    widget.onBtnPressed();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: 80.0,
      color: widget.isActive ? Colors.blueGrey : widget.isGood ? Colors.green : Colors.red,
      onPressed: widget.isActive ? _onPressed : () => {},
      child: new Text(widget.text,
        style: new TextStyle(
            fontSize: 12.0,
            color: Colors.white
        ),
      ),
    );
  }

}