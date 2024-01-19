import 'package:dio/dio.dart';

class Book {
  final int id;
  final String image;
  final String name;
  final String description;
  final String author;
  final int price;
  final String genre;

  Book(this.id, this.image, this.name, this.description, this.author,
      this.price, this.genre);

  // factory Book.fromJson(Map<String, dynamic> json) {
  //   return Book(
  //     json['id'],
  //     json['image'],
  //     json['name'],

  //     json['avg'],
  //   );
  // }

  // Map<String, dynamic> toJson() => {
  //       'name': name,
  //       'avg': avg,
  //     };
  Book.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        image = json['image'],
        name = json['name'],
        description = json['description'],
        author = json['author'],
        // price = json['price'],
        // price = int.parse(json['price']),
        price = int.tryParse(json['price'].toString()) ?? 0,
        genre = json['genre'];
}

class HttpClient {
  static Dio instance =
      Dio(BaseOptions(baseUrl: 'https://mostafamohammadi.liara.run/'));
}

Future<List<Book>> getBooks() async {
  final response = await HttpClient.instance.get('list.php');
  final List<Book> books = [];

  if (response.data is List<dynamic>) {
    for (var element in (response.data as List<dynamic>)) {
      books.add(Book.fromJson(element));
    }
  }

  return books;
}