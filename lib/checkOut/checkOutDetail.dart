import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:square_in_app_payments/models.dart';

String chargeServerHost = 'https://us-central1-chat-6902b.cloudfunctions.net/nonce';
String chargeServerHostSquare = 'https://connect.squareupsandbox.com/v2/payments';
var token = '';

class Payment{
  String errorMessage;
  Payment(this.errorMessage);
}

Future<void> getToken(CardDetails result) async {
  var chargeUrl = "$chargeServerHost";
  var body = jsonEncode({"nonce": result.nonce});
  print("get nonce");
      print(result.nonce);
  http.Response response;
  try{
    response = await http.post(chargeUrl, body: body, headers: {
      "content-type": "application/json",
    });
  } on SocketException catch (ex){
    throw Payment(ex.message);
  }
  var responseBody = json.decode(response.body);
  if(response.statusCode == 200){
    token = response.body.replaceRange(0, 1, "");
    token = token.replaceRange(71, 72, "");
    return;
  }else{
    throw Payment(responseBody["errorMessage"]);
  }
}
int random() {
    var rng = Random();
    int a;
    for (var i = 0; i < 10; i++) {
      a = rng.nextInt(100000000);
    }
    return a;
  }
Future<void> chargeCard(CardDetails result, int price,String email) async {
  var chargeUrlSquare = "$chargeServerHostSquare";
  int number =random();
  var body = jsonEncode({
    'idempotency_key': '$email.user.$number',
    'autocomplete': true,
    'amount_money': {'amount': price, 'currency': 'USD'},
    'source_id': 'cnon:card-nonce-ok',
    'customer_id': '',
    'delay_capture': false
  });
  http.Response response;
  try{
    response = await http.post(chargeUrlSquare, body: body, headers: {
      "Accept": "application/json",
      "content-type": "application/json",
      "Authorization": token,
    });
    print(response);
  } on SocketException catch (ex){
    throw Payment(ex.message);
  }
  var responseBody = json.decode(response.body);
  if(response.statusCode == 200){
    print(responseBody);
    return;
  }else{
     print(responseBody);
    throw Payment(responseBody["errorMessage"]);
  }
}