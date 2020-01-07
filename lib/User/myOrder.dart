import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'OrderModel.dart';

class MyOrders extends StatefulWidget {
  final String id;
  MyOrders(this.id);
  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  List<Order> _notes = List<Order>();
  List<Order> _notesForDisplay = List<Order>();

  Future<List<Order>> fetchNotes() async {
    var response = await http.get(
        'http://192.168.10.7/irabwah/CheckOut/myOrders.php?id=${widget.id}');
     //   'http://app.irabwah.com/app_data/CheckOut/myOrders.php?id=${widget.id}');

    var notes = List<Order>();

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      for (var noteJson in data) {
        notes.add(Order.fromJson(noteJson));
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
        body: Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Image.asset(
          "images/backround2.jpg",
          fit: BoxFit.fill,
        ),
        FutureBuilder<List<Order>>(
            future: fetchNotes(),
            builder: (context, product) {
              return product.data== null ?
               Column(
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        Icon(
                          Icons.remove_shopping_cart,
                          size: 40,
                        ),
                        Center(
                          child: Text(
                            'No Orders',
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ],
                    )
                  : _notesForDisplay.length == 0
              ? Container(
                  alignment: AlignmentDirectional.center,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Color(0xffe50914))
                  ),
                )
              :ListView.builder(
                      itemCount: _notesForDisplay.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                           
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.red,
                          offset: Offset(5, 5),
                          blurRadius: 10.0,
                      )
                    ]),
                         
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Icon(Icons.local_shipping,color: Colors.red,),
                                  ],
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text(
                                        (_notesForDisplay[index].productName),style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'Price:\$ ' +
                                            double.parse(_notesForDisplay[index]
                                                    .productPrice)
                                                .toStringAsFixed(2),
                                      ),
                                      
                                       Text(
                                        'Quantity:' +
                                            (_notesForDisplay[index]
                                                    .productQuantity).toString(),
                                                
                                      ),
                                      
                                      
                                    ],
                                  ),
                                ),
                              ]),
                            ),
                          ),
                        );
                      });
             
            }),
      ],
    ));
  }
}
