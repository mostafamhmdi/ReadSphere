import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class Book {
  final int id;
  final String name;
  final String author;
  final String rating;
  final String description;
  final String genres;
  final String price;
  final String book_path;
  Book(
    this.id,
    this.name,
    this.author,
    this.rating,
    this.description,
    this.price,
    this.genres,
    this.book_path,
  );

  Book.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        author = json['author'],
        rating = json['rating'],
        description = json['description'],
        genres = json['genres'],
        price = json['price'],
        book_path = json['book_path'];
}

class HttpClient {
  static Dio instance =
      Dio(BaseOptions(baseUrl: 'https://mostafamohammadi.liara.run/'));
}

Future<List<Book>> getGenres(String selectedGenre) async {
  final response = await HttpClient.instance
      .get('genres.php', queryParameters: {'genre': selectedGenre});
  final List<Book> books = [];

  if (response.data is List<dynamic>) {
    for (var element in (response.data as List<dynamic>)) {
      books.add(Book.fromJson(element));
    }
  }

  return books;
}

Future<List<Book>> getBooks(String selectedName) async {
  final response = await HttpClient.instance
      .get('books.php', queryParameters: {'name': selectedName});
  final List<Book> books = [];

  if (response.data is List<dynamic>) {
    for (var element in (response.data as List<dynamic>)) {
      books.add(Book.fromJson(element));
    }
  }

  return books;
}

Future<Book> saveBook(String name, String author, String rating,
    String description, String genres, String price, String book_path) async {
  final response = await HttpClient.instance.post('create.php', data: {
    "name": name,
    "author": author,
    "rating": rating,
    "description": description,
    "genres": genres,
    "price": price,
    "book_path": book_path,
  });

  if (response.statusCode == 200) {
    return Book.fromJson(response.data);
  } else {
    throw Exception();
  }
}

Future CreateBook(String name, String author, String rating, String description,
    String genres, String price, String book_path) async {
  var response = await http.post(
    Uri.parse("https://mostafamohammadi.liara.run/create.php"),
    body: {
      "name": name,
      "author": author,
      "rating": rating,
      "description": description,
      "genres": genres,
      "price": price,
      "book_path": book_path,
    },
  );

  return response;
}

Future updateBook(
  String name,
  String author,
  String rating,
  String description,
  String genres,
  String price,
) async {
  var response = await http.post(
    Uri.parse("https://mostafamohammadi.liara.run/update.php"),
    body: {
      "name": name,
      "author": author,
      "rating": rating,
      "description": description,
      "genres": genres,
      "price": price,
    },
  );

  return response;
}

Future<List<Book>> getFavoriteBooks() async {
  final response = await HttpClient.instance.get('getfavbooks.php');
  final List<Book> books = [];

  if (response.data is List<dynamic>) {
    for (var element in (response.data as List<dynamic>)) {
      books.add(Book.fromJson(element));
    }
  }

  return books;
}
