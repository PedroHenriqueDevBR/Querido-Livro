class StringText {
  static String ENGLISH = 'english';
  static String DEFAULT = 'default';

  // General
  String appName = 'Querido Livro';
  String dashboard = 'Painel de controle';
  String borrowedBook = 'Livros emprestados';
  String receivedBook = 'Livros recebidos';

  // Dashboard data
  String registered = 'Livros cadastrados';
  String reading = 'Em leitura';
  String borrowed = 'Livro emprestado';
  String received = 'Livro recebido';

  // NavigationBar
  String home = 'Home';
  String books = 'Livros';
  String profile = 'Perfil';

  // Model data
  String noValue = 'Não especificado';

  StringText.changeTo(String language) {
    if (language == ENGLISH) {
      // General
      this.appName = 'Dear Book';
      this.dashboard = 'Dashboard';
      this.borrowedBook = 'Borrowed';
      this.receivedBook = 'Received';

      // Dashboard data
      this.registered = 'Registered books';
      this.reading = 'Reading';
      this.borrowed = 'Borrowed book';
      this.received = 'Received book';

      // NavigationBar
      this.home = 'Home';
      this.books = 'Books';
      this.profile = 'Profile';

      // Model data
      this.noValue = 'uninformed';
    }
  }
}
