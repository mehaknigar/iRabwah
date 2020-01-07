import 'package:connectivity/connectivity.dart';

Future<bool> checkConn() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile ||
      connectivityResult == ConnectivityResult.wifi) {
    return true; //RETURNING TRUE IF CONNECTED
  } else {
    return false; //RETURNING FALSE IF NOT CONNECTEDS
  }
}
