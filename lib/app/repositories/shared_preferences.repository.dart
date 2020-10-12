import 'package:meu_querido_livro/app/interfaces/language_storage.interface.dart';
import 'package:meu_querido_livro/app/utils/string_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesRepository implements ILanguageStorage {
  SharedPreferences sharedPreferences;

  Future initSharedPreference() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  Future<String> getLanguage() {
    sharedPreferences.getString(StringText.LANGUAGE);
  }

  @override
  Future<void> setLanguage(String language) async {
    await sharedPreferences.setString(StringText.LANGUAGE, language);
  }
}
