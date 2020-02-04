import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../Models/Note.dart';
import '../Models/SqliteHandler.dart';
import '../Models/Utility.dart';
import '../Views/StaggeredTiles.dart';
import 'HomePage.dart';
import 'NotePage.dart';

class StaggeredGridPage extends StatefulWidget {
  final notesViewType;
  const StaggeredGridPage({Key key, this.notesViewType}) : super(key: key);
  @override
  _StaggeredGridPageState createState() => _StaggeredGridPageState();
}

class _StaggeredGridPageState extends State<StaggeredGridPage> {

  var  noteDB = NotesDBHandler();
  List<Map<String, dynamic>> _allNotesInQueryResult = [];
  viewType notesViewType ;

@override
  void initState() {
    super.initState();
    this.notesViewType = widget.notesViewType;
  }


@override void setState(fn) {
    super.setState(fn);
    this.notesViewType = widget.notesViewType;
  }

  @override
  Widget build(BuildContext context) {


    GlobalKey _stagKey = GlobalKey();

    print("update needed?: ${CentralStation.updateNeeded}");
    if(CentralStation.updateNeeded) {  retrieveAllNotesFromDatabase();  }
    return new GestureDetector(
      onTap: () {
        _newNoteTapped(context);
      },
      child: Container(child: Padding(padding:  _paddingForView(context) , child:
      new StaggeredGridView.count(key: _stagKey,
        crossAxisSpacing: 6,
        mainAxisSpacing: 6,
        crossAxisCount: _colForStaggeredView(context),
        children: List.generate(_allNotesInQueryResult.length, (i){ return _tileGenerator(i); }),
        staggeredTiles: _tilesForView() ,
      ),
      ),
      ),
    );
  }

  void _newNoteTapped(BuildContext ctx) {
    // "-1" id indicates the note is not new
    var emptyNote = new Note(-1, "", "", DateTime.now(), DateTime.now(), Colors.white);
    Navigator.push(ctx,MaterialPageRoute(builder: (ctx) => NotePage(emptyNote)));
  }

  void _toggleViewType(){
    setState(() {
      CentralStation.updateNeeded = true;
      if(notesViewType == viewType.List)
      {
        notesViewType = viewType.Staggered;

      } else {
        notesViewType = viewType.List;
      }

    });
  }


  int _colForStaggeredView(BuildContext context) {

      if (widget.notesViewType == viewType.List)
      return 1;
      return MediaQuery.of(context).size.width > 600 ? 3:2  ;
  }

 List<StaggeredTile> _tilesForView() {
  return List.generate(_allNotesInQueryResult.length,(index){ return StaggeredTile.fit(1); }
  ) ;
}


EdgeInsets _paddingForView(BuildContext context){
  double width = MediaQuery.of(context).size.width;
  double padding ;
  double top_bottom = 8;
  if (width > 500) {
    padding = ( width ) * 0.05 ;
  } else {
    padding = 8;
  }
  return EdgeInsets.only(left: padding, right: padding, top: top_bottom, bottom: top_bottom);
}


  MyStaggeredTile _tileGenerator(int i){
 return MyStaggeredTile(  Note(
      _allNotesInQueryResult[i]["id"],
      _allNotesInQueryResult[i]["title"] == null ? "" : utf8.decode(_allNotesInQueryResult[i]["title"]),
      _allNotesInQueryResult[i]["content"] == null ? "" : utf8.decode(_allNotesInQueryResult[i]["content"]),
     DateTime.fromMillisecondsSinceEpoch(_allNotesInQueryResult[i]["date_created"] * 1000),
     DateTime.fromMillisecondsSinceEpoch(_allNotesInQueryResult[i]["date_last_edited"] * 1000),
      Color(_allNotesInQueryResult[i]["note_color"] ))
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




