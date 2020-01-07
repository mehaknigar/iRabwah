import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:irabwah/Cart/cart.dart';
import 'package:irabwah/Cart/cartController.dart';
import 'package:irabwah/Models/categoryModel.dart';
import 'package:provider/provider.dart';

class Description1 extends StatefulWidget {
  final Note data;
  Description1(this.data);

  @override
  _Description1State createState() => _Description1State();
}

class _Description1State extends State<Description1> {
  final globalKey = GlobalKey<ScaffoldState>();
  void showSnackbar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('Product Added to Cart'),
      duration: Duration(milliseconds: 500),
    );
    globalKey.currentState.showSnackBar(snackBar);
  }

  int no = 1;
  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<CartController>(context);
    int totalCount = cart.items.length;
    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(widget.data.name),
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 150.0,
              width: 30.0,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyCart(),
                    ),
                  );
                },
                child: Stack(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      ),
                      onPressed: null,
                    ),
                    Positioned(
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            top: 3.0,
                            right: 20,
                            child: Center(
                              child: Text(
                                '$totalCount',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Stack(
            children: <Widget>[
              Container(
                height: 200,
                width: double.infinity,
                child: CachedNetworkImage(
                  imageUrl:
                      'http://store.irabwah.com/image/' + widget.data.image,
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
              Container(
                margin: EdgeInsets.fromLTRB(16, 200, 16, 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                padding: const EdgeInsets.all(10.0),
                child: Column(children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          widget.data.name,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Text(
                          'Price= \$' +
                              double.parse(widget.data.price)
                                  .toStringAsFixed(2),
                          style: TextStyle(color: Colors.red, fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  'QTY:',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                IconButton(
                                  icon: Icon(Icons.remove),
                                  onPressed: () {
                                    if (no > 1) {
                                      setState(() {
                                        no--;
                                      });
                                    }
                                  },
                                ),
                                Text(no.toString()),
                                IconButton(
                                  icon: Icon(Icons.add),
                                  onPressed: () {
                                    setState(() {
                                      no++;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              cart.addProduct(widget.data, no);
                              showSnackbar(context);
                            },
                            child: Card(
                              shape: BeveledRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              elevation: 3.0,
                              color: Colors.red,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 8, 15, 8),
                                child: Text(
                                  'Add To Cart',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 2,
                        color: Colors.red,
                      ),
                    ],
                  ),
                  Container(
                  //  height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.red,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              'Product Description:',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                  child: Text(
                                'Name:\t' + widget.data.name,
                                softWrap: true,
                                style: TextStyle(color: Colors.black),
                              )),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  'Model:\t' + widget.data.model,
                                  softWrap: true,
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  'Meta Description:\t' +
                                      widget.data.metadescripion,
                                  softWrap: true,
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
