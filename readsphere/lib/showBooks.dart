import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:readsphere/addbook.dart';
import 'package:readsphere/data.dart';
import 'package:readsphere/main.dart';
import 'package:readsphere/showBooks.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // for json

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
        title: Image.network(
          'https://mostafamohammdi.storage.iran.liara.space/White%20logo%20-%20no%20background.png',
          width: MediaQuery.of(context).size.width * 0.4,
          alignment: Alignment.center,
        ),
        centerTitle: true,
        backgroundColor: AppColors.accentColor,
        iconTheme: IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: Icon(CupertinoIcons.back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Categories()),
            );
          },
        ),
      ),
      backgroundColor: AppColors.accentColor,
      body: Column(
        children: [
          // Add your text here
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.genre,
              style: TextStyle(
                color: AppColors.secondaryColor,
                fontFamily: 'SairaCondensed',
                fontSize: 30.0,
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
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookDetails(data: data),
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
              color: Colors.black, // Set your desired background color here
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                        15.0), // Set your desired border radius here
                    child: Image.network(
                      data.book_path,
                      fit: BoxFit.cover,
                      height: MediaQuery.of(context).size.height * 0.35,
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
  final Book data;
  const BookDetails({Key? key, required this.data}) : super(key: key);

  @override
  State<BookDetails> createState() => _BookDetails();
}

class _BookDetails extends State<BookDetails> {
  bool isHeartRed = false;
  void deleteStudent(context) async {
    await http.post(
      Uri.parse("https://mostafamohammadi.liara.run/delete.php"),
      body: {
        'id': widget.data.id.toString(),
      },
    );
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) {
      return BookPage(genre: widget.data.genres);
    }), (route) => false);
  }

  void confirmDelete(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.accentColor,
          content: Text(
            'Are you sure you want to delete this?',
            style: TextStyle(color: Colors.white),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Icon(
                Icons.cancel,
                color: Colors.green,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              child: Icon(
                Icons.check_circle,
                color: Colors.red,
              ),
              onPressed: () => deleteStudent(context),
            ),
          ],
        );
      },
    );
  }

  void addToFavorites(context, int BookID) async {
    final response = await http.post(
      Uri.parse("https://mostafamohammadi.liara.run/addtofavorites.php"),
      body: {
        'book_id': BookID.toString(),
      },
    );

    final jsonResponse = json.decode(response.body);

    if (jsonResponse.containsKey('message')) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(milliseconds: 1000),
          content: Text(
            jsonResponse['message'],
            style: TextStyle(color: AppColors.secondaryColor),
          ),
          backgroundColor: AppColors.primaryColor,
        ),
      );
    }
  }

  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    String truncatedDescription = widget.data.description.length > 100
        ? widget.data.description.substring(0, 100) + '...'
        : widget.data.description;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.accentColor,
          iconTheme: IconThemeData(
            color: AppColors.primaryColor,
          ),
          leading: PopupMenuButton(
            color: AppColors.accentColor,
            icon: Icon(FontAwesomeIcons.ellipsisVertical),
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                child: ListTile(
                  title: Text(
                    'Books',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 17),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              BookPage(genre: widget.data.genres)),
                    );
                  },
                ),
              ),
              PopupMenuItem(
                child: ListTile(
                  title: Text(
                    'Genres',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 17),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Categories()),
                    );
                  },
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(
                FontAwesomeIcons.edit,
                color: AppColors.primaryColor,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Edit(widget.data)),
                );
              },
            ),
            IconButton(
              icon: Icon(
                Icons.delete,
                color: AppColors.primaryColor,
              ),
              onPressed: () => confirmDelete(context),
            )
          ],
        ),
        backgroundColor: AppColors.accentColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: FutureBuilder<List<Book>>(
                future: getBooks(widget.data.name),
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
                                            MediaQuery.of(context).size.height *
                                                0.45,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.6,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.03,
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: AppColors.secondaryColor,
                                              size: 28,
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
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
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.09,
                                            ),
                                            Text(
                                              'Rating',
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      100, 255, 255, 255),
                                                  fontSize: 21,
                                                  fontFamily: 'SairaCondensed',
                                                  fontWeight: FontWeight.w700),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.07,
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              FontAwesomeIcons.bookOpenReader,
                                              color: AppColors.secondaryColor,
                                              size: 28,
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
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
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.09,
                                            ),
                                            Text(
                                              'Pages',
                                              style: TextStyle(
                                                  fontSize: 21,
                                                  fontFamily: 'SairaCondensed',
                                                  color: Color.fromARGB(
                                                      100, 255, 255, 255),
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.07,
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.people,
                                              color: AppColors.secondaryColor,
                                              size: 28,
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
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
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.08,
                                            ),
                                            Text(
                                              'Popular',
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      100, 255, 255, 255),
                                                  fontSize: 21,
                                                  fontFamily: 'SairaCondensed',
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.03,
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.75, // Set a specific width for the container
                                          child: Text(
                                            book.name,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'BarlowCondensed',
                                              fontSize: 27,
                                              fontWeight: FontWeight.w700,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.05,
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
                                            color: isHeartRed
                                                ? Colors.red
                                                : Colors.grey,
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
                                          color: const Color.fromARGB(
                                              255, 153, 149, 149),
                                          fontSize: 20),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: new Container(
                                        margin: const EdgeInsets.only(
                                            left: 10.0, right: 20.0),
                                        child: Divider(
                                          color: AppColors.secondaryColor,
                                          height: 36,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "Description",
                                      style: TextStyle(
                                          color: AppColors.secondaryColor,
                                          fontSize: 20),
                                    ),
                                    Expanded(
                                      child: new Container(
                                          margin: const EdgeInsets.only(
                                              left: 20.0, right: 10.0),
                                          child: Divider(
                                            color: AppColors.secondaryColor,
                                            height: 36,
                                          )),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isExpanded = !isExpanded;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      isExpanded
                                          ? book.description
                                          : truncatedDescription,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 17),
                                    ),
                                  ),
                                ),
                                if (!isExpanded &&
                                    book.description.length > 100)
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isExpanded = true;
                                      });
                                    },
                                    child: Container(
                                      child: Text(
                                        "More",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  margin: const EdgeInsets.only(bottom: 16.0),
                                  child: FloatingActionButton(
                                    onPressed: () =>
                                        addToFavorites(context, widget.data.id),
                                    backgroundColor: AppColors.secondaryColor,
                                    child: Text(
                                      'Add to Favorites',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
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
            ),
          ],
        ));
  }
}
