import 'package:flutter/material.dart';

class IFHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return IFHomeState();
  }
}

class IFHomeState extends State<IFHome> {
  static bool fasting = false;
  static bool textFieldStatus = true;
  String _fastingLabel = 'Today is a great Day To Fast';
  var _fastedHours;
  double _targetFasting = 0.0;
  DateTime _fastingStart = DateTime.now();
  DateTime _fastingEnd;
  String _raisedButtonLabel = 'Let\'s Start';
  static TextEditingController _fastingDurationTEControler =
      TextEditingController();
  int radioValue = 0;
  void handleRadioValueChanged(int value) {
    setState(() {
      radioValue = value;
    });
  }

  void handleDurationSubmitted() {
    if (_fastingDurationTEControler.text.isNotEmpty) {
      _targetFasting = double.parse(_fastingDurationTEControler.text);
    }
  }

  void _startStopFasting() {
    debugPrint('$fasting');
    setState(() {
      fasting = !fasting;
      if (fasting) {
        _fastingLabel = 'You are fasting for $_targetFasting hours';
        handleDurationSubmitted();
      } else {
        _fastingLabel = 'Today is a great Day To Fast';
      }
    });
  }

  void _startByRB(bool status) {
    //int.parse(StringVariable)
    //StringVariable.isNotEmpty (no empty string parameter check)
    // int.parse(StringVariable) > Integer
    if (!status) {
      _raisedButtonLabel = 'I\'m Done for Today';
      textFieldStatus = false;
      _targetFasting = double.parse(_fastingDurationTEControler.text);
      _startStopFasting();
      _fastingEnd = DateTime.now();
      _fastedHours = _fastingEnd.difference(_fastingStart);
      debugPrint('$_fastedHours');
    } else {
      _raisedButtonLabel = 'Let\'s Start';
      textFieldStatus = true;
      _startStopFasting();
      _fastingStart = DateTime.now();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'IF Tracker',
          textScaleFactor: 1.0,
          style: TextStyle(
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.amber,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.import_export),
              onPressed: () => debugPrint('Will implement Import/Export soon')),
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: () => debugPrint('Will implement settings soon'))
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              title: Text(_raisedButtonLabel), icon: Icon(Icons.track_changes)),
          BottomNavigationBarItem(
              title: Text('History'), icon: Icon(Icons.history)),
        ],
        onTap: (int i) {
          if (i == 0) {
            debugPrint('$fasting');
          } else {
            debugPrint('To build history page call later');
          }
        },
      ),
      body: Container(
        padding: EdgeInsets.all(30.5),
        alignment: Alignment.center,
        color: Colors.amberAccent.shade100,
        child: ListView(
          children: <Widget>[
            Text(_fastingLabel),
            //child:
            Container(
              height: 100.0,
              width: 300.0,
              color: Colors.amberAccent.shade50,
              child: TextField(
                controller: _fastingDurationTEControler,
                keyboardType: TextInputType.number,
                enabled: textFieldStatus,
                decoration: InputDecoration(
                    hintText: 'Targeted Duration',
                    labelText: 'How long do you plan to fast?',
                    icon: Icon(Icons.timer)),
                keyboardAppearance: Brightness.dark,
                onTap: () => debugPrint('TF Tapped'),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Radio<int>(
                    value: 0,
                    groupValue: radioValue,
                    onChanged: handleRadioValueChanged),
                Text('Count Down'),
                Radio<int>(
                    value: 1,
                    groupValue: radioValue,
                    onChanged: handleRadioValueChanged),
                Text('Count Up'),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
            ),
            Container(
              child: RaisedButton(
                onPressed: () {
                  if (_fastingDurationTEControler.text.isNotEmpty) {
                    _startByRB(fasting);
                  }
                },
                child: Text(_raisedButtonLabel),
              ),
            )
          ],
        ),
      ),
    );
  }
}
