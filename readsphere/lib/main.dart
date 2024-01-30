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

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  int _selectedIndex = 0;
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
      backgroundColor: AppColors.accentColor,
      appBar: AppBar(
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
          Image.network(
            'https://mostafamohammdi.storage.iran.liara.space/White%20logo%20-%20no%20background.png',
            width: MediaQuery.of(context).size.width * 0.7,
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

                if (index == 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddBook()),
                  );
                } else if (index == 2) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FavoriteBook()),
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
        padding: const EdgeInsets.fromLTRB(4, 8, 0, 0),
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Color.fromRGBO(234, 234, 234, 1),
          borderRadius: BorderRadius.circular(40.0),
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
                    fontSize: 30,
                    color: Colors.black,
                    fontFamily: 'SairaCondensed',
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.034,
                ),
                Image.network(
                  category.imageUrl,
                  height: MediaQuery.of(context).size.height * 0.22,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
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
                  ],
                )
              ],
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
