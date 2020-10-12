class StringText {
  // static String ENGLISH = 'english';
  static String DEFAULT = 'default';

  // General
  String appName = 'Querido Livro';
  String dashboard = 'Painel de controle';
  String borrowedBook = 'Livros emprestados';
  String receivedBook = 'Livros recebidos';
  String loading = 'Carregando';
  String internalError = 'Ocorreu um erro interno, tente novamente mais tarde';
  String fillInTheFields = 'Preencha os campos abaixo';

  // Login data
  String password = 'Senha';
  String enter = 'Entrar';
  String enterMail = 'Digite o seu e-mail';
  String enterPass = 'Digite a sua senha';
  String invalidEmail = 'E-mail inválido';
  String invalidCredential = 'Credenciais incorretas';
  String wantToRegisterMessage = 'Se não for cadastrado, clique em "quero me cadastrar"';
  String loginPage = 'Página de acesso';
  String wantToRegister = 'Quero me cadastrar';

  // Create User data
  String verifyYourEmail = 'Verifique a sua caixa de e-mail para finalizar o seu cadastro';
  String differentEmails = 'Os e-mails digitados são diferentes';
  String createUser = 'Cadastro de usuário';
  String name = 'Nome completo';
  String confirmEmail = 'Confirmar e-mail';
  String awaitEmail = 'Após o cadastro aguarde o e-mail.\nUm e-mail será enviado solicitando a criação de uma senha.';
  String register = 'Registrar';
  String goBack = 'Voltar';

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
    // if (language == ENGLISH) {
    //   // General
    //   this.appName = 'Dear Book';
    //   this.dashboard = 'Dashboard';
    //   this.borrowedBook = 'Borrowed';
    //   this.receivedBook = 'Received';
    //   this.loading = 'Loading';
    //   this.internalError = 'An internal error has occurred, please try again later';
    //   this.fillInTheFields = 'Fill in all fields';
    //
    //   // Login data
    //   this.password = 'Password';
    //   this.enter = 'Login';
    //   this.enterMail = 'Enter your e-mail';
    //   this.enterPass = 'Enter your password';
    //   this.invalidEmail = 'Invalid e-mail';
    //   this.invalidCredential = 'Invalid credential';
    //   this.wantToRegisterMessage = 'If you are not registered, click on "I want to sign up"';
    //   this.loginPage = 'Access page';
    //   this.wantToRegister = 'I want to sign up';
    //
    //   // Create User data
    //   this.verifyYourEmail = 'Check your email box to complete your registration';
    //   this.differentEmails = 'Error: different emails';
    //   this.createUser = 'Create new user';
    //   this.name = 'Name';
    //   this.confirmEmail = 'Confirm e-mail';
    //   this.awaitEmail = 'After registration wait for the email.\nAn email will be sent requesting the creation of a password.';
    //   this.register = 'Register';
    //   this.goBack = 'Go back';
    //
    //   // Dashboard data
    //   this.registered = 'Registered books';
    //   this.reading = 'Reading';
    //   this.borrowed = 'Borrowed book';
    //   this.received = 'Received book';
    //
    //   // NavigationBar
    //   this.home = 'Home';
    //   this.books = 'Books';
    //   this.profile = 'Profile';
    //
    //   // Model data
    //   this.noValue = 'uninformed';
    // }
  }
}
