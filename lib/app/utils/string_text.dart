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
  String borrowed = 'Livros emprestados';
  String received = 'Livros recebidos';

  // NavigationBar
  String home = 'Home';
  String books = 'Livros';
  String profile = 'Perfil';

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
      this.borrowed = 'Borrowed books';
      this.received = 'Received book';

      // NavigationBar
      this.home = 'Home';
      this.books = 'Books';
      this.profile = 'Profile';
    }
  }
}
