import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:readsphere/fav_books.dart';

import 'package:readsphere/showBooks.dart';
import 'package:readsphere/addbook.dart';

void main() {
  runApp(const MyApp());
}

class AppColors {
  static const Color primaryColor = Color.fromRGBO(234, 234, 234, 1);
  static const Color accentColor = Color.fromRGBO(9, 19, 25, 1);
  static const Color secondaryColor = Color.fromRGBO(234, 141, 0, 1);
  // static const Color secondaryColor = Color.fromRGBO(51, 51, 51, 1);
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
    var _selectedIndex = 0;

    return Scaffold(
      backgroundColor: AppColors.accentColor,
      appBar: AppBar(
        // title: const Text(
        //   'Readsphere',
        //   style: TextStyle(color: Colors.white),
        //   textAlign: TextAlign.center,
        // ),
        iconTheme: IconThemeData(
          color: AppColors.accentColor,
        ),
        backgroundColor: AppColors.accentColor,
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Text(
            'REDASPHERE',
            style: TextStyle(fontSize: 35, color: Colors.white),
          ),
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.75,
                        child: CategoryCard(category: categories[index]),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(50.0),
              topRight: Radius.circular(50.0),
              bottomLeft: Radius.circular(50.0),
              bottomRight: Radius.circular(50.0),
            ),
            child: Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.01),
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.1,
              color: AppColors.secondaryColor,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 8),
                    child: GNav(
                      selectedIndex: _selectedIndex,
                      // backgroundColor: Colors.black,
                      rippleColor: AppColors.accentColor,
                      hoverColor: AppColors.accentColor,
                      tabBackgroundColor: AppColors.accentColor,
                      gap: 8,
                      activeColor: AppColors.secondaryColor,
                      iconSize: 24,
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 12),
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
                        if (index == 1) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AddBook()),
                          );
                        } else if (index == 2) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FavoriteBook()),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
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
        height: MediaQuery.of(context).size.height * 0.5,
        alignment: Alignment.center,
        padding: const EdgeInsets.fromLTRB(4, 8, 4, 0),
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Color.fromRGBO(234, 234, 234, 1),
          // color: Color.fromRGBO(110, 68, 254, 1),
          // color: Color.fromRGBO(69, 69, 69, 1),
          borderRadius: BorderRadius.circular(40.0),
          // boxShadow: [
          //   BoxShadow(
          //     color: Color.fromRGBO(217, 207, 206, 1),
          //     spreadRadius: 1,
          //     blurRadius: 5,
          //     offset: const Offset(0, 5),
          //   ),
          // ],
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Text(
                  category.name,
                  style: const TextStyle(
                    fontSize: 27,
                    color: Colors.black,
                    // color: Color.fromRGBO(81, 113, 150, 1),
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                Image.network(
                  category.imageUrl,
                  height: MediaQuery.of(context).size.height * 0.22,
                  fit: BoxFit.cover,
                ),
              ],
            ),
            Positioned(
              right: -MediaQuery.of(context).size.width * 0.12,
              // left: 0,
              bottom: 0,
              child: Container(
                width: MediaQuery.of(context).size.width *
                    0.25, // Adjust the width as needed
                height: MediaQuery.of(context).size.height *
                    0.12, // Adjust the height as needed
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35.0),
                    bottomRight: Radius.circular(35.0),
                    bottomLeft: Radius.circular(5.0),
                    topRight: Radius.circular(5.0),
                  ),
                ),
                child: Icon(
                  FontAwesomeIcons.add,
                  size: 40,
                  color: Colors.white,
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
