import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:irabwah/Models/categoryModel.dart';
import 'package:irabwah/categories/SubCatgories/descriptionProduct.dart';

class SubProduct extends StatefulWidget {
  final int id;
  final String name;
  SubProduct(this.id, this.name);
  @override
  _SubProductState createState() => _SubProductState();
}

class _SubProductState extends State<SubProduct> {
  List<Note> _notes = List<Note>();
  List<Note> _notesForDisplay = List<Note>();
  Future<List<Note>> fetchNotes() async {
    var url =
        'http://app.irabwah.com/app_data/Products/allProducts.php?id=${widget.id}';
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
        print(_notes);
        _notes.addAll(value);
        _notesForDisplay = _notes;
      });
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.name),
          centerTitle: true,
          backgroundColor: Colors.red,
          bottom: _searchBar(),
        ),
        body: _notes.length == 0
            ? Center(
                child: CircularProgressIndicator(),
              )
            : GridView.builder(
                itemCount: _notesForDisplay.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (BuildContext context, int index) {
                  return SubProductDisplay(_notesForDisplay[index]);
                }));
  }

  _searchBar() {
    return PreferredSize(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          shape:
              BeveledRectangleBorder(borderRadius: BorderRadius.circular(10)),
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

class SubProductDisplay extends StatelessWidget {
  final Note data;
  SubProductDisplay(this.data);
  @override
  Widget build(BuildContext context) {
    return data == null
        ? Text('No Product')
        : GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Description1(data),
                ),
              );
            },
            child: Card(
              elevation: 4.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: Container(
                      height: 200,
                      child: CachedNetworkImage(
                        imageUrl:
                            'http://store.irabwah.com/image/' + data.image,
                        placeholder: (context, url) => Container(
                          margin: EdgeInsets.all(20),
                          child: Container(
                            height: 20,
                            width: 50,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                              backgroundColor: Colors.red,
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Text(
                            data.name,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Center(
                            child: Text(
                              'Price:\$ ' +
                                  double.parse(data.price).toStringAsFixed(2),
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
