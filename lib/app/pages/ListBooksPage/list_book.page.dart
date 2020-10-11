import 'package:flutter/material.dart';
import 'package:meu_querido_livro/app/models/book.model.dart';
import 'package:meu_querido_livro/app/pages/CreateBookPage/create_book.controller.dart';
import 'package:meu_querido_livro/app/pages/CreateBookPage/create_book.page.dart';
import 'package:meu_querido_livro/app/pages/ListBooksPage/list_book.controller.dart';
import 'package:meu_querido_livro/app/routes.dart';
import 'package:meu_querido_livro/app/singleton/book.singleton.dart';
import 'package:provider/provider.dart';

class ListBookPage extends StatefulWidget {
  @override
  _ListBookPageState createState() => _ListBookPageState();
}

class _ListBookPageState extends State<ListBookPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ListBookController>(context, listen: false).getBooksFromDatabase();
      Provider.of<CreateBookController>(context, listen: false).currentBook = null;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodyWidget(),
      floatingActionButton: fab(),
    );
  }

  /*
   * My widgets
   */
  Widget _bodyWidget() {
    return Consumer<ListBookController>(
      builder: (context, bookController, child) {
        return bookController.loadedBooks ? _listAllBooksWidget() : _loadingData();
      },
    );
  }

  Widget _listAllBooksWidget() {
    List<BookModel> books = BookSingleton.instance.books;
    if (books.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Opacity(
              opacity: 0.3,
              child: Image.asset(
                'assets/images/livro.png',
                height: 200,
                colorBlendMode: BlendMode.colorBurn,
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Mantenha o hábito da leitura, que tal adicionar um livro e começar a ler hoje mesmo?',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      );
    } else {
      return ListView.builder(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(8),
        itemCount: BookSingleton.instance.books.length,
        itemBuilder: (context, index) {
          return _bookItemWidget(BookSingleton.instance.books[index]);
        },
      );
    }
  }

  Widget _bookItemWidget(BookModel book) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _bookItemHeaderWidget(book),
          _bookItemImageWidget(book),
          _bookItemInfoWidget(book),
          _bookItemPercentWidget(book),
        ],
      ),
    );
  }

  FloatingActionButton fab() {
    ListBookController bookController = Provider.of<ListBookController>(context);
    return FloatingActionButton.extended(
      backgroundColor: bookController.colorPalette.secondColor,
      foregroundColor: bookController.colorPalette.lightColor,
      icon: Icon(Icons.add),
      label: Text('Adicionar'),
      onPressed: () {
        Navigator.pushNamed(context, RouteWidget.CREATE_BOOK_ROUTE, arguments: null).then((_) {
          bookController.getBooksFromDatabase();
        });
      },
    );
  }

  /*
  * auxiliary widgets
  */
  Widget _bookItemHeaderWidget(BookModel book) {
    ListBookController bookController = Provider.of<ListBookController>(context);
    return ListTile(
      title: Text(
        book.name != null ? book.name : '',
        style: TextStyle(fontWeight: FontWeight.w500),
      ),
      trailing: IconButton(
        icon: Icon(Icons.edit),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateBookPage(
                book: book,
              ),
            ),
          ).then((_) {
            bookController.getBooksFromDatabase();
          });
        },
      ),
    );
  }

  Widget _bookItemImageWidget(BookModel book) {
    ListBookController bookController = Provider.of<ListBookController>(context);
    return Container(
      color: Colors.grey[100],
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width * 0.4,
      child: bookController.isUrlImageFromBook(book)
          ? Image.network(
              bookController.getUrlImageFromBook(book),
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            )
          : Image.asset(
              bookController.getAssetImageFromBook(),
            ),
    );
  }

  Widget _bookItemInfoWidget(BookModel book) {
    return Container(
      padding: EdgeInsets.all(8),
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          ListTile(
            subtitle: Text(
              book.description,
              maxLines: 5,
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
          ),
          Text(
            'Páginas lidas: ${book.readPageCount} de ${book.bookPageCount}',
            textAlign: TextAlign.end,
          ),
        ],
      ),
    );
  }

  Widget _bookItemPercentWidget(BookModel book) {
    ListBookController bookController = Provider.of<ListBookController>(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
      ),
      child: LinearProgressIndicator(
        backgroundColor: Colors.white,
        value: bookController.getPercentPages(
          book.readPageCount,
          book.bookPageCount,
        ),
      ),
    );
  }

  Widget _loadingData() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
