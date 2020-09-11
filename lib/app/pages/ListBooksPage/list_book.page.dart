import 'package:flutter/material.dart';
import 'package:meu_querido_livro/app/interfaces/book_storage.interface.dart';
import 'package:meu_querido_livro/app/interfaces/person_storage.interface.dart';
import 'package:meu_querido_livro/app/models/book.model.dart';
import 'package:meu_querido_livro/app/models/person.model.dart';
import 'package:meu_querido_livro/app/pages/CreateBookPage/create_book.page.dart';
import 'package:meu_querido_livro/app/repositories/book.repository.dart';
import 'package:meu_querido_livro/app/repositories/person.repository.dart';
import 'package:meu_querido_livro/app/routes.dart';
import 'package:meu_querido_livro/app/utils/color_palette.dart';
import 'package:meu_querido_livro/app/utils/string_text.dart';

class ListBookPage extends StatefulWidget {
  @override
  _ListBookPageState createState() => _ListBookPageState();
}

class _ListBookPageState extends State<ListBookPage> {
  List<BookModel> books = [];
  ColorPalette _colorPalette = new ColorPalette();
  StringText _stringText = new StringText.changeTo(StringText.ENGLISH);
  IBookStorage _storage = BookFirebase();
  IPersonStorage _personStorage = PersonFirebase();
  bool loadedBooks = true;

  Future getBooksFromDatabase() async {
    setState(() {
      loadedBooks = false;
    });
    PersonModel person = await _personStorage.getLoggedUser();
    List<BookModel> responseBook = await _storage.getUserBooks(person);
    setState(() {
      books = responseBook;
      loadedBooks = true;
    });
  }

  double getPercentPages(calc, total) {
    double percent = ((calc * 100) / total) / 100;
    return percent;
  }

  bool isUrlImageFromBook(BookModel book) {
    if (book.pictureUrl == null) {
      return false;
    } else if (book.pictureUrl.isEmpty) {
      return false;
    }
    return true;
  }

  String getAssetImageFromBook() {
    return 'assets/images/livro.png';
  }

  String getUrlImageFromBook(BookModel book) {
    return book.pictureUrl;
  }

  @override
  void initState() {
    getBooksFromDatabase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loadedBooks
          ? ListView.builder(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.all(8),
              itemCount: books.length,
              itemBuilder: (context, index) {
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
                      ListTile(
                        title: Text(
                          books[index].name,
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CreateBookPage(
                                  book: books[index],
                                ),
                              ),
                            ).then((_) {
                              getBooksFromDatabase();
                            });
                          },
                        ),
                      ),
                      Container(
                        color: Colors.grey[100],
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width * 0.4,
                        child: isUrlImageFromBook(books[index])
                            ? Image.network(
                                getUrlImageFromBook(books[index]),
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
                                getAssetImageFromBook(),
                              ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            ListTile(
                              subtitle: Text(
                                books[index].description,
                                maxLines: 5,
                                style: TextStyle(fontSize: 16, height: 1.5),
                              ),
                            ),
                            Text(
                              'Páginas lidas: ${books[index].readPageCount} de ${books[index].bookPageCount}',
                              textAlign: TextAlign.end,
                            ),
                          ],
                        ),
                      ),
                      Container(
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
                          value: getPercentPages(books[index].readPageCount, books[index].bookPageCount),
                        ),
                      ),
                    ],
                  ),
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: _colorPalette.secondColor,
        foregroundColor: _colorPalette.lightColor,
        icon: Icon(Icons.add),
        label: Text('Adicionar'),
        onPressed: () {
          Navigator.pushNamed(context, RouteWidget.CREATE_BOOK_ROUTE);
        },
      ),
    );
  }
}
