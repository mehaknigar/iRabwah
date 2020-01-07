import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:irabwah/Models/categoryModel.dart';
import 'package:irabwah/categories/reusable.dart';

class Combination extends StatefulWidget {
  @override
  _CombinationState createState() => _CombinationState();
}
class _CombinationState extends State<Combination> {
  List<Note> _notes = List<Note>();
  List<Note> _notesForDisplay = List<Note>();

  Future<List<Note>> fetchNotes() async {
    var url = 'http://app.irabwah.com/app_data/Products/categories.php?id=77';
    var response = await http.get(url);

    var notes = List<Note>();

    if (response.statusCode == 200) {
      var notesJson = json.decode(response.body);
      for (var noteJson in notesJson) {
        notes.add(Note.fromJson(noteJson));
      }
    }
    return notes;
  }

  @override
  void initState() {
    fetchNotes().then((value) {
      setState(() {
        _notes.addAll(value);
        _notesForDisplay = _notes;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Combination'),
          centerTitle: true,
          backgroundColor: Colors.red,
           bottom: _searchBar(),
         
        ),
        body: GridView.builder(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (context, index) {
            return Reusable(_notesForDisplay[index]);
          },
          itemCount: _notesForDisplay.length,
        ));
  }
  

  _searchBar() {
    return PreferredSize(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
            shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(10)),
            child: TextField(
            cursorColor: Colors.red,
            decoration: InputDecoration(
              hintText: 'Search Here',
              border: InputBorder.none,
              icon: IconButton(
                icon: Icon(Icons.search),
                color: Colors.red,
                onPressed: () {},
              ),
            ),
            onChanged: (text) {
              text = text.toLowerCase();
              setState(() {
                _notesForDisplay = _notes.where((note) {
                  var noteTitle = note.name.toLowerCase();
                  return noteTitle.contains(text);
                }).toList();
              });
            },
          ),
        ),
      ),
      preferredSize: Size.fromHeight(40),
    );
  }
}

