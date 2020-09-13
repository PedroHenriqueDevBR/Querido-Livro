import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesRepository {
  SharedPreferences sharedPreferences;

  Future initSharedPreference() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }
}
