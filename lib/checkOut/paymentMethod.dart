import 'package:flutter/material.dart';
import 'package:irabwah/Cart/cartController.dart';
import 'package:irabwah/Models/categoryModel.dart';
import 'package:irabwah/Sign_in_up/userModel.dart';
import 'package:irabwah/User/updateData.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:square_in_app_payments/in_app_payments.dart';
import 'package:square_in_app_payments/models.dart';
import 'package:sweetalert/sweetalert.dart';
import 'checkOutDetail.dart';

class PaymentMethod extends StatefulWidget {
  @override
  _PaymentMethodState createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  User user;
  bool loggedInPresent = false, loggedIn = false;
  SharedPreferences sharedPreferences;
  int selectedRadioButton;
  @override
  void initState() {
    super.initState();
    selectedRadioButton = 0;
    ini();
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadioButton = val;
    });
  }

  void ini() async {
    sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      loggedInPresent = sharedPreferences.containsKey('LoggedIn');
      if (loggedInPresent) {
        loggedIn = sharedPreferences.getBool('LoggedIn');
        print(sharedPreferences.getString('address_2'));
      }
    });
  }

  String payment, userEmail;
  void checkOut(data, totalPrice, payment) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String id = sharedPreferences.getString('customer_id');
    userEmail = sharedPreferences.getString('customer_id');
    addOrder(id, totalPrice, data, payment);
  }

  void addOrder(String id, double totalPrice, data, String payment) async {
    http.Response response = await http.get(
      "http://app.irabwah.com/app_data/CheckOut/order.php?id=$id&totalPrice=$totalPrice&payment=$payment",
    );

    for (Note item in data) {
      var proId = item.id;
      var name = item.name;
      var price = item.price;
      var qty = item.qty;
      makeHttpRequest(id, proId, name, price, qty, totalPrice);
    }
  }

  _paymentSuccessDialog(BuildContext context, String payment) {
    SweetAlert.show(context,
        title: payment,
        subtitle: "Your Order has been Placed!",
        style: SweetAlertStyle.success, onPress: (bool confirm) {
      Provider.of<CartController>(context).clear();
      Navigator.pop(context, true);
    });
  }

  void makeHttpRequest(String id, int proId, String name, String price, int qty,
      double totalPrice) async {
    http.Response response = await http.get(
      "http://app.irabwah.com/app_data/CheckOut/checkOut.php?id=$id&proId=$proId&name=$name&price=$price&qty=$qty&totalPrice=$totalPrice",
    );
  }

  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<CartController>(context);
    void _pay(double total) async {
      String payment = 'Credit Card';
      int price = (total * 100).toInt();
      await InAppPayments.setSquareApplicationId(
          'sq0idp-0oO2b7vOtlVNE6IpGna-5Q');
      await InAppPayments.startCardEntryFlow(
          onCardNonceRequestSuccess: (CardDetails result) async {
        try {
          await getToken(result);
          await chargeCard(result, price, userEmail);
          InAppPayments.completeCardEntry(onCardEntryComplete: () async {
            checkOut(cart.items, cart.totalCartValue, payment);
            cart.clear();
            Navigator.pop(context);
            _paymentSuccessDialog(context, payment);
          });
        } catch (ex) {
          InAppPayments.showCardNonceProcessingError(ex.toString());
        }
      }, onCardEntryCancel: () {
        Navigator.pop(context);
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Method'),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        padding:
            EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 10.0),
        child: Column(children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Subtotal"),
              Text("\$. ${cart.totalCartValue.toStringAsFixed(2)}"),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Total",
                style: Theme.of(context).textTheme.title,
              ),
              Text("\$. ${cart.totalCartValue.toStringAsFixed(2)}",
                  style: Theme.of(context).textTheme.title),
            ],
          ),
          SizedBox(
            height: 15.0,
          ),
          Container(
            color: Colors.grey.shade200,
            padding: EdgeInsets.all(8.0),
            width: double.infinity,
            child: Text("Name".toUpperCase()),
          ),
          SizedBox(
            height: 15.0,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Name",
                ),
                Text(
                  sharedPreferences.getString('firstname') +
                      ' ' +
                      sharedPreferences.getString('lastname'),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Container(
              color: Colors.grey.shade200,
              padding: EdgeInsets.all(8.0),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Delivery Address".toUpperCase()),
                  GestureDetector(
                    child: Icon(Icons.edit, color: Colors.red),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UpdateData()));
                    },
                  ),
                ],
              )),
          SizedBox(
            height: 15.0,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Shipping Address",
                ),
                Text(
                  sharedPreferences.getString('address_2') +
                      ',' +
                      sharedPreferences.getString('city'),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Shipping Country",
                ),
                Text(
                  'Pakistan',
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Container(
              color: Colors.grey.shade200,
              padding: EdgeInsets.all(8.0),
              width: double.infinity,
              child: Text("Contact Number".toUpperCase())),
          SizedBox(
            height: 15.0,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Number"),
                Text(
                  sharedPreferences.getString('telephone'),
                ),
              ],
            ),
          ),
          Column(
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              Container(
                  color: Colors.grey.shade200,
                  padding: EdgeInsets.all(8.0),
                  width: double.infinity,
                  child: Text("Payment Option".toUpperCase())),
              RadioListTile(
                groupValue: selectedRadioButton,
                value: 1,
                activeColor: Colors.red,
                title: Text("Cash on Delivery"),
                onChanged: (val) {
                  setSelectedRadio(val);
                },
              ),
              RadioListTile(
                groupValue: selectedRadioButton,
                value: 2,
                activeColor: Colors.red,
                title: Text('Credit Card'),
                onChanged: (val) {
                  setSelectedRadio(val);
                },
              ),
              GestureDetector(
                onTap: () {
                  if (selectedRadioButton == 1) {
                    payment = 'Cash On delivery';
                    checkOut(cart.items, cart.totalCartValue, payment);
                    _paymentSuccessDialog(context, payment);
                  } else {
                    _pay(cart.totalCartValue);
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  width: double.infinity,
                  color: Colors.red,
                  child: Center(
                    child: Text(
                      "Place Order",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ]),
      ),
    );
  }
}
