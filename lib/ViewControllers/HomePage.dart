import 'package:demo_13/ViewControllers/HistoryPage.dart';
import 'package:flutter/material.dart';
import 'StaggeredView.dart';
import '../Models/Note.dart';
import 'NotePage.dart';
import '../Models/Utility.dart';
import 'AlarmPage.dart';

enum viewType {
  List,
  Staggered
}


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var notesViewType ;
  @override void initState() {
    notesViewType = viewType.Staggered;
  }

  @override
  Widget build(BuildContext context) {

    return
       Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(brightness: Brightness.light,
        actions: <Widget>[
          IconButton(
          icon: const Icon(Icons.access_alarm, color: Colors.black,),
         tooltip: 'Show Snackbar',
         onPressed: () {
           _alarmtap(context);
         },
       ),IconButton(
            icon: const Icon(Icons.history, color: Colors.black,),
            tooltip: 'History',
            onPressed: () {
              _historytap(context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.add, color: Colors.black,),
            tooltip: 'History',
            onPressed: () {
              _newNoteTapped(context);
            },
          ),
        ],
        elevation: 1,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text("Notes"),
      ),
      body: SafeArea(child:   _body(), right: true, left:  true, top: true, bottom: true,),
    );

  }

  Widget _body() {
    print(notesViewType);
    return Container(child: StaggeredGridPage(notesViewType: notesViewType,));
  }

  void _newNoteTapped(BuildContext ctx) {
    var emptyNote = new Note(-1, "", "", DateTime.now(), DateTime.now(), Colors.white);
    Navigator.push(ctx,MaterialPageRoute(builder: (ctx) => NotePage(emptyNote)));
  }

  void _alarmtap(BuildContext ctx) {

    Navigator.push(ctx,MaterialPageRoute(builder: (ctx) => AlarmPage()));
  }
  void _historytap(BuildContext ctx) {

    Navigator.push(ctx,MaterialPageRoute(builder: (ctx) => HistoryPage()));
  }


}
