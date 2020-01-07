import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:irabwah/Cart/cartController.dart';
import 'package:irabwah/Sign_in_up/sign_in.dart';
import 'package:irabwah/checkOut/paymentMethod.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MyCart extends StatelessWidget {
  @override
  @override
  Widget build(BuildContext context) {
    Future<bool> _onWillPop() async {
      return showDialog<bool>(
          context: context,
          builder: (_) {
            return AlertDialog(
              content: Text("Are you sure you want to Empty your Cart?"),
              title: Text("Warning!"),
              actions: <Widget>[
                FlatButton(
                  child: Text("Yes"),
                  onPressed: () {
                    Navigator.pop(context, true);
                    Provider.of<CartController>(context).clear();
                  },
                ),
                FlatButton(
                  child: Text("No"),
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                ),
              ],
            );
          });
    }
var cart = Provider.of<CartController>(context);
    return Scaffold(
      appBar: AppBar(
          title: Text('My Cart'),
          backgroundColor: Colors.red,
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              onPressed: () => _onWillPop(),
              icon: Icon(
                Icons.delete_forever,
                color: Colors.white,
                size: 30,
              ),
            ),
          ]),
      body: Column(
        children: [
          Expanded(
            child: _CartList(),
          ),
         cart.items.length>0? _CartTotal():SizedBox(height: 0,),
        ],
      ),
    );
  }
}

class _CartList extends StatefulWidget {
  @override
  __CartListState createState() => __CartListState();
}

class __CartListState extends State<_CartList> {
  double total = 0.00;
  int no = 1;
  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<CartController>(context);

    return cart.items.length == 0
        ? Column(
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
                  'Cart Is Empty',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
              ),
            ],
          )
        : ListView.builder(
            itemCount: cart.items.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 3,
                  child: Row(children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 125,
                        width: 110,
                        child: CachedNetworkImage(
                          imageUrl: 'http://store.irabwah.com/image/' +
                              cart.items[index].image,
                          placeholder: (context, url) => Container(
                            margin: EdgeInsets.all(20),
                            child: Container(
                              height: 20,
                              width: 50,
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
                                backgroundColor: Colors.red,
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              cart.items[index].name,
                              softWrap: true,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.red,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              '\$ ' +
                                  (double.parse(cart.items[index].price))
                                      .toString() +
                                  ' X ${cart.items[index].qty.toString()}',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                            Text(
                              '=\$ ${(double.parse(cart.items[index].price) * cart.items[index].qty).toStringAsFixed(2)}',
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                            Row(
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(Icons.remove),
                                  onPressed: () {
                                    if (cart.items[index].qty > 1) {
                                      cart.remoProduct(cart.items[index]);
                                    }
                                  },
                                ),
                                Text(cart.items[index].qty.toString()),
                                IconButton(
                                  icon: Icon(Icons.add),
                                  onPressed: () {
                                    cart.addAProduct(cart.items[index]);
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 30,
                      width: 30,

                      alignment: Alignment.center,

                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2.0)),
                        padding: EdgeInsets.all(0.0),
                        color: Colors.red,
                        child: Icon(
                          Icons.clear,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          cart.updateProduct(
                              cart.items[index], cart.items[index].qty = 0);
                        },
                      ),

                    )
                  ]),
                ),
              );
            });
  }
}

class _CartTotal extends StatefulWidget {
  @override
  __CartTotalState createState() => __CartTotalState();
}

class __CartTotalState extends State<_CartTotal> {
  bool loggedInPresent = false, loggedIn = false;
  SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    ini();
  }

  void ini() async {
    sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      loggedInPresent = sharedPreferences.containsKey('LoggedIn');
      if (loggedInPresent) {
        loggedIn = sharedPreferences.getBool('LoggedIn');
        print(sharedPreferences.getString('firstname'));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var cartController = Provider.of<CartController>(context);
    return SizedBox(
      height: 50,
      child: Container(
        color: Colors.red,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Consumer<CartController>(
                builder: (context, cart, child) => Text(
                    'Total:\$${cart.totalCartValue.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
              SizedBox(width: 24),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    if (loggedInPresent) {
                      print('log in present true');
                      if (loggedIn) {
                        print('into loggin condition true');
                         Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PaymentMethod(),
                                ),
                              );
                      } else {
                        print('into false loggin condition false');
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignIn(),
                          ),
                        );
                      }
                    } else {
                      print('log in present false');
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignIn(),
                        ),
                      );
                    }
                  },
                  child: Container(
                    height: 50,
                    color: Colors.white,
                    padding: EdgeInsets.all(6),
                    child: Text(
                      'Proceed to Payment',
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
