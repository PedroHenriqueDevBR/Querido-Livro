class StringText {
  static String ENGLISH = 'english';
  static String DEFAULT = 'default';

  // General
  String appName = 'Querido Livro';
  String dashboard = 'Painel de controle';
  String borrowedBook = 'Livros emprestados';
  String receivedBook = 'Livros recebidos';
  String loading = 'Carregando';

  // Login data
  String password = 'Senha'; // Password
  String enter = 'Entrar'; // Login
  String enterMail = 'Digite o seu e-mail'; // Enter your e-mail
  String enterPass = 'Digite a sua senha'; // Enter your password
  String invalidEmail = 'E-mail inválido'; // Invalid e-mail
  String invalidCredential = 'Credenciais incorretas'; // Invalid credential
  String internalError = 'Ocorreu um erro interno, tente novamente mais tarde'; // An internal error has occurred, please try again later
  String fillInTheFields = 'Preencha os campos abaixo para realizar o login na aplicação'; // Fill in the fields below to login
  String wantToRegisterMessage = 'Se não for cadastrado, clique em "quero me cadastrar"'; // If you are not registered, click on "I want to sign up"
  String loginPage = 'Página de acesso'; // Access page
  String wantToRegister = 'Quero me cadastrar'; // I want to sign up

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
      this.loading = 'Loading';

      // Login data
      this.password = 'Password';
      this.enter = 'Login';
      this.enterMail = 'Enter your e-mail';
      this.enterPass = 'Enter your password';
      this.invalidEmail = 'Invalid e-mail';
      this.invalidCredential = 'Invalid credential';
      this.internalError = 'An internal error has occurred, please try again later';
      this.fillInTheFields = 'Fill in the fields below to login';
      this.wantToRegisterMessage = 'If you are not registered, click on "I want to sign up"';
      this.loginPage = 'Access page';
      this.wantToRegister = 'I want to sign up';

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
