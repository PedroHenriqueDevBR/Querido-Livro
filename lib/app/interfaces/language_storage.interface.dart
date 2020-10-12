abstract class ILanguageStorage {

  Future<void> setLanguage(String language);

  Future<String> getLanguage();

}