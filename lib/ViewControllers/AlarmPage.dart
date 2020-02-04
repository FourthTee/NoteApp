import 'package:flutter/material.dart';
import 'package:android_alarm_manager/android_alarm_manager.dart';

class AlarmPage extends StatefulWidget {

  @override
  _AlarmPageState createState() => new _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {



  @override
  void initState() {
    super.initState();
    this.alarm();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Alarm"),
      ),
    );
  }


  alarm() async {
    final int helloAlarmID = 0;
    await AndroidAlarmManager.initialize();

  }


}