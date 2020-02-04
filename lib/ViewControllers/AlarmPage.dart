import 'package:flutter/material.dart';

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

  }


}