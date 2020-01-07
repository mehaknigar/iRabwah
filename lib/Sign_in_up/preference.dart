import 'package:irabwah/Sign_in_up/userModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceManager {
  //detail save
  static void saveDetails(User user) async {
    SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance(); //used everywhere
    await sharedPreferences.setBool('LoggedIn', true);
    await sharedPreferences.setString("customer_id", user.id.toString());
    await sharedPreferences.setString("telephone", user.telephone.toString());
    await sharedPreferences.setString("firstname", user.firstname);
    await sharedPreferences.setString("lastname", user.lastname);
    await sharedPreferences.setString("email", user.email);
    await sharedPreferences.setString("password", user.password);
    await sharedPreferences.setString("address_1", user.address_1);
    await sharedPreferences.setString("address_2", user.address_2);
    await sharedPreferences.setString("city", user.city);
  }

  static Future<User> getDetails() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    
    String id = sharedPreferences.getString("customer_id") ?? null;
    String telephone = sharedPreferences.getString("telephone") ?? null;
    String firstname = sharedPreferences.getString("firstname") ?? null; //set,get,
    String lastname = sharedPreferences.getString("lastname") ?? null;
    String email = sharedPreferences.getString("email") ?? null;
    String password = sharedPreferences.getString("password") ?? null;
    String address_1 = sharedPreferences.getString("address_1") ?? null;
    String address_2 = sharedPreferences.getString("address_2") ?? null;
    String city = sharedPreferences.getString("city") ?? null;

    return User(id,telephone,firstname, lastname, email, password,address_1,address_2,city);
  }

  static removeDetails() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }
}
