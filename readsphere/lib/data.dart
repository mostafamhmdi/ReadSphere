import 'package:dio/dio.dart';

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
