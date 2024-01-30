import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:readsphere/addbook.dart';
import 'package:readsphere/data.dart';
import 'package:readsphere/main.dart';
import 'package:readsphere/showBooks.dart';

import 'package:http/http.dart' as http;

class FavoriteBook extends StatefulWidget {
  const FavoriteBook({Key? key}) : super(key: key);

  @override
  State<FavoriteBook> createState() => _FavoriteBook();
}

class _FavoriteBook extends State<FavoriteBook> {
  var _selectedIndex = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.accentColor,
        flexibleSpace: Center(
          child: Image.network(
            'https://mostafamohammdi.storage.iran.liara.space/White%20logo%20-%20no%20background.png',
            width: MediaQuery.of(context).size.width * 0.4,
            alignment: Alignment.center,
          ),
        ),
      ),
      backgroundColor: AppColors.accentColor,
      body: Column(
        children: [
          // Add your text here
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: Text(
              'Favorite Books',
              style: TextStyle(
                color: AppColors.secondaryColor,
                fontSize: 23.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          // FutureBuilder for your ListView
          Expanded(
            child: FutureBuilder<List<Book>>(
              future: getFavoriteBooks(),
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
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.secondaryColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(50.0),
            topRight: Radius.circular(50.0),
            bottomLeft: Radius.circular(50.0),
            bottomRight: Radius.circular(50.0),
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              textStyle: TextStyle(
                  fontFamily: 'Signika',
                  color: AppColors.secondaryColor,
                  fontSize: 20),
              selectedIndex: _selectedIndex,
              rippleColor: AppColors.accentColor,
              hoverColor: AppColors.accentColor,
              tabBackgroundColor: AppColors.accentColor,
              gap: 8,
              activeColor: AppColors.secondaryColor,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              duration: Duration(milliseconds: 400),
              // tabBackgroundColor: Colors.grey[100]!,
              color: AppColors.primaryColor,
              tabs: [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: CupertinoIcons.book,
                  text: 'Add',
                ),
                GButton(
                  icon: Icons.favorite_border,
                  text: 'Favorites',
                ),
                GButton(
                  icon: FontAwesomeIcons.user,
                  text: 'Profile',
                ),
              ],

              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });

                if (index == 0) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Categories()),
                  );
                } else if (index == 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddBook()),
                  );
                }
              },
            ),
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
