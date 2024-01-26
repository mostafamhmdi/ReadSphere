// ignore_for_file: depend_on_referenced_packages

import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:readsphere/data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Readsphere',
      theme: ThemeData(
        inputDecorationTheme:
            const InputDecorationTheme(border: OutlineInputBorder()),
      ),
      home: Categories(),
    );
  }
}

class Categories extends StatelessWidget {
//const Categories({Key? key}) : super(key: key);
  final List<CategoryData> categories = [
    CategoryData('Adventure',
        'https://mostafamohammdi.storage.iran.liara.space/adventure.png'),
    CategoryData('Classics',
        'https://mostafamohammdi.storage.iran.liara.space/classical.png'),
    CategoryData('Fantasy',
        'https://mostafamohammdi.storage.iran.liara.space/fantasy.png'),
    CategoryData('Historical',
        'https://mostafamohammdi.storage.iran.liara.space/historical.png'),
    CategoryData('Horror',
        'https://mostafamohammdi.storage.iran.liara.space/horror.png'),
    CategoryData('Philosophy',
        'https://mostafamohammdi.storage.iran.liara.space/philosophi.png'),
    CategoryData('Romance',
        'https://mostafamohammdi.storage.iran.liara.space/romance.png'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(28, 31, 33, 1),
      appBar: AppBar(
        title: const Text(
          'Readsphere',
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        backgroundColor: const Color.fromRGBO(28, 31, 33, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Center(
                child: SizedBox(
                  width: 300,
                  child: CategoryCard(category: categories[index]),
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
          bottomLeft: Radius.circular(30.0),
          bottomRight: Radius.circular(30.0),
        ),
        child: SizedBox(
          height: 90,
          child: BottomNavigationBar(
            backgroundColor: const Color.fromRGBO(255, 191, 0, 1),
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  FontAwesomeIcons.gears,
                  size: 40,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  FontAwesomeIcons.book,
                  size: 40,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  FontAwesomeIcons.userTie,
                  size: 40,
                ),
                label: '',
              ),
            ],
            selectedItemColor: const Color.fromRGBO(28, 31, 33, 1),
            unselectedItemColor: const Color.fromRGBO(28, 31, 33, 0.5),
            currentIndex: 1,
            onTap: (index) {
              if (index == 0) {
                // Handle navigation to settings
              } else if (index == 2) {
                // Handle navigation to user profile
              }
            },
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final CategoryData category;

  const CategoryCard({required this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookPage(genre: category.name),
          ),
        );
      },
      child: Container(
        height: 500,
        alignment: Alignment.center,
        padding: const EdgeInsets.fromLTRB(4, 8, 4, 0),
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade600,
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 5),
            ),
            BoxShadow(
              color: Colors.grey.shade300,
              offset: const Offset(-5, 0),
            ),
            BoxShadow(
              color: Colors.grey.shade300,
              offset: const Offset(5, 0),
            )
          ],
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  category.name,
                  style: const TextStyle(
                    fontSize: 27,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 60,
                ),
                Image.network(
                  category.imageUrl,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ],
            ),
            Positioned(
              right: -46,
              // left: 0,
              bottom: 0,
              child: Container(
                width: 120, // Adjust the width as needed
                height: 120, // Adjust the height as needed
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(255, 191, 0, 1),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35.0),
                    bottomRight: Radius.circular(25.0),
                    bottomLeft: Radius.circular(5.0),
                    topRight: Radius.circular(5.0),
                  ),
                ),
                child: Icon(
                  FontAwesomeIcons.heart,
                  size: 40,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryData {
  final String name;
  final String imageUrl;

  const CategoryData(this.name, this.imageUrl);
}

class BookPage extends StatefulWidget {
  final String genre;
  const BookPage({Key? key, required this.genre}) : super(key: key);

  @override
  State<BookPage> createState() => _BookPage();
}

class _BookPage extends State<BookPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(28, 31, 33, 1),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Color.fromRGBO(28, 31, 33, 1),
      body: Column(
        children: [
          // Add your text here
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: Text(
              widget.genre,
              style: TextStyle(
                color: Colors.white,
                fontSize: 23.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          // FutureBuilder for your ListView
          Expanded(
            child: FutureBuilder<List<Book>>(
              future: getGenres(widget.genre),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  return ListView.builder(
                    padding: const EdgeInsets.only(bottom: 84),
                    itemCount: (snapshot.data!.length / 2).ceil(),
                    itemBuilder: (context, index) {
                      int startIndex = index * 2;
                      int endIndex = (index + 1) * 2;
                      if (endIndex > snapshot.data!.length) {
                        endIndex = snapshot.data!.length;
                      }

                      List<Book> rowData =
                          snapshot.data!.sublist(startIndex, endIndex);

                      return _BookRow(data: rowData);
                    },
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
          bottomLeft: Radius.circular(30.0),
          bottomRight: Radius.circular(30.0),
        ),
        child: SizedBox(
          height: 90,
          child: BottomNavigationBar(
            backgroundColor: const Color.fromRGBO(255, 191, 0, 1),
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  FontAwesomeIcons.gears,
                  size: 40,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  FontAwesomeIcons.book,
                  size: 40,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  FontAwesomeIcons.userTie,
                  size: 40,
                ),
                label: '',
              ),
            ],
            selectedItemColor: const Color.fromRGBO(28, 31, 33, 1),
            unselectedItemColor: const Color.fromRGBO(28, 31, 33, 0.5),
            currentIndex: 1,
            onTap: (index) {
              if (index == 0) {
                // Handle navigation to settings
              } else if (index == 2) {
                // Handle navigation to user profile
              }
            },
          ),
        ),
      ),
    );
  }
}

class _BookRow extends StatelessWidget {
  final List<Book> data;

  const _BookRow({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _Book(data: data[0]),
        if (data.length > 1) _Book(data: data[1]),
      ],
    );
  }
}

class _Book extends StatelessWidget {
  final Book data;

  const _Book({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: GestureDetector(
          onTap: () {
            // Navigate to another page when the image is tapped
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookDetails(name: data.name),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black, // Set the background color here
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  color:
                      const Color.fromARGB(255, 255, 253, 253).withOpacity(0.5),
                  spreadRadius: 2,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Container(
              color: Colors.white12, // Set your desired background color here
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                        15.0), // Set your desired border radius here
                    child: Image.network(
                      data.book_path,
                      fit: BoxFit.cover,
                      height: 300,
                      width: MediaQuery.of(context).size.width / 2 - 16,
                    ),
                  ),
                  SizedBox(height: 5),
                  RatingBar.builder(
                    initialRating: double.parse(data.rating),
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 25.0,
                    unratedColor: Colors.grey,
                    itemBuilder: (context, _) => Material(
                      type: MaterialType.transparency,
                      child: Icon(
                        Icons.star,
                        color: Color.fromRGBO(255, 191, 0, 1),
                      ),
                    ),
                    onRatingUpdate: (rating) {
                      // Handle the rating update
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BookDetails extends StatefulWidget {
  final String name;
  const BookDetails({Key? key, required this.name}) : super(key: key);

  @override
  State<BookDetails> createState() => _BookDetails();
}

class _BookDetails extends State<BookDetails> {
  bool isHeartRed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(28, 31, 33, 1),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Color.fromRGBO(28, 31, 33, 1),
      body: FutureBuilder<List<Book>>(
        future: getBooks(widget.name),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            List<Book> books = snapshot.data!;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView.builder(
                itemCount: books.length,
                itemBuilder: (context, index) {
                  Book book = books[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Image.network(
                                book.book_path,
                                height:
                                    MediaQuery.of(context).size.height * 0.45,
                                width: MediaQuery.of(context).size.width * 0.6,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.05,
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Color.fromRGBO(255, 191, 0, 1),
                                      size: 28,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.015,
                                    ),
                                    Text(
                                      book.rating,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w800),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.09,
                                    ),
                                    Text(
                                      'Rating',
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              100, 255, 255, 255),
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.07,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.bookOpenReader,
                                      color: Color.fromRGBO(252, 10, 10, 0.737),
                                      size: 28,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.015,
                                    ),
                                    Text(
                                      '${Random(10).nextInt(344) + 195}',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w800),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.09,
                                    ),
                                    Text(
                                      'Pages',
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              100, 255, 255, 255),
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.07,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.people,
                                      color: Color.fromRGBO(252, 10, 10, 0.737),
                                      size: 28,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.015,
                                    ),
                                    Text(
                                      book.price,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w800),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.08,
                                    ),
                                    Text(
                                      'Popular',
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              100, 255, 255, 255),
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                        Row(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width *
                                      0.75, // Set a specific width for the container
                                  child: Text(
                                    book.name,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.05,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isHeartRed =
                                          !isHeartRed; // Toggle the color on each tap
                                    });
                                  },
                                  child: Icon(
                                    CupertinoIcons.heart_fill,
                                    color:
                                        isHeartRed ? Colors.red : Colors.grey,
                                    size: 30,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Row(
                          children: [
                            Text(
                              book.author,
                              style: TextStyle(
                                  color:
                                      const Color.fromARGB(255, 153, 149, 149),
                                  fontSize: 20),
                            )
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: new Container(
                                  margin: const EdgeInsets.only(
                                      left: 10.0, right: 20.0),
                                  child: Divider(
                                    color: Colors.white,
                                    height: 36,
                                  )),
                            ),
                            Text(
                              "Description",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            Expanded(
                              child: new Container(
                                  margin: const EdgeInsets.only(
                                      left: 20.0, right: 10.0),
                                  child: Divider(
                                    color: Colors.white,
                                    height: 36,
                                  )),
                            ),
                          ],
                        ),
                        Text(
                          book.description,
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        )
                      ],
                    ),
                  );
                },
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
          bottomLeft: Radius.circular(30.0),
          bottomRight: Radius.circular(30.0),
        ),
        child: SizedBox(
          height: 90,
          child: BottomNavigationBar(
            backgroundColor: const Color.fromRGBO(255, 191, 0, 1),
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  FontAwesomeIcons.gears,
                  size: 40,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  FontAwesomeIcons.book,
                  size: 40,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  FontAwesomeIcons.userTie,
                  size: 40,
                ),
                label: '',
              ),
            ],
            selectedItemColor: const Color.fromRGBO(28, 31, 33, 1),
            unselectedItemColor: const Color.fromRGBO(28, 31, 33, 0.5),
            currentIndex: 1,
            onTap: (index) {
              if (index == 0) {
                // Handle navigation to settings
              } else if (index == 2) {
                // Handle navigation to user profile
              }
            },
          ),
        ),
      ),
    );
  }
}
