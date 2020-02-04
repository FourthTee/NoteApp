import 'package:flutter/material.dart';
import 'dart:convert';
import '../Models/SqliteHandler.dart';
import '../Models/Utility.dart';
import 'HomePage.dart';



class HistoryPage extends StatefulWidget {

  @override
  _HistoryPageState createState() => new _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {

  var  noteDB = NotesDBHandler();
  List<Map<String, dynamic>> _allNotesInQueryResult = [];
  viewType notesViewType ;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    retrieveAllNotesFromDatabase();
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("History"),
      ),
      body:  new ListView.builder(
        itemCount: _allNotesInQueryResult == null ? 0 : _allNotesInQueryResult.length,
        itemBuilder: (BuildContext context, int index){
          return new Container(
            child: new Center(
              child:  new Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  new Card(
                    child: new Container(
                      child: new Text(utf8.decode(_allNotesInQueryResult[index]["title"])),
                      padding: const EdgeInsets.all(20.0),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void retrieveAllNotesFromDatabase() {
    var _testData = noteDB.selectAllNotes();
    _testData.then((value){
      setState(() {
        this._allNotesInQueryResult = value;
        CentralStation.updateNeeded = false;
      });
    });
  }

}