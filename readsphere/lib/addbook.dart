import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:readsphere/data.dart';
import 'package:readsphere/main.dart';
import 'package:readsphere/showBooks.dart';
import 'package:readsphere/fav_books.dart';
import 'package:http/http.dart' as http;

class AddBook extends StatelessWidget {
  final TextEditingController name = TextEditingController();
  final TextEditingController author = TextEditingController();
  final TextEditingController rating = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController genres = TextEditingController();
  final TextEditingController price = TextEditingController();
  final TextEditingController book_path = TextEditingController();
  var _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.accentColor,
        actions: [
          IconButton(
              onPressed: () async {
                try {
                  final newStudentData = await CreateBook(
                      name.text,
                      author.text,
                      rating.text,
                      description.text,
                      genres.text,
                      price.text,
                      book_path.text);
                  Navigator.pop(context, newStudentData);
                } catch (e) {
                  debugPrint(e.toString());
                }
              },
              icon: Icon(
                Icons.check,
                color: AppColors.secondaryColor,
                size: 33,
              ))
        ],
      ),
      backgroundColor: AppColors.accentColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: name,
              decoration: const InputDecoration(
                label: Text(
                  'Book Name',
                  style: TextStyle(color: AppColors.secondaryColor),
                ),
              ),
              style: TextStyle(color: AppColors.primaryColor),
            ),
            const SizedBox(
              height: 8,
            ),
            TextField(
              controller: author,
              decoration: const InputDecoration(
                label: Text(
                  'Author Name',
                  style: TextStyle(color: AppColors.secondaryColor),
                ),
              ),
              style: TextStyle(color: AppColors.primaryColor),
            ),
            const SizedBox(
              height: 8,
            ),
            TextField(
              controller: rating,
              decoration: const InputDecoration(
                label: Text(
                  'Rating',
                  style: TextStyle(color: AppColors.secondaryColor),
                ),
              ),
              style: TextStyle(color: AppColors.primaryColor),
            ),
            const SizedBox(
              height: 8,
            ),
            TextField(
              controller: description,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                label: Text(
                  'Description',
                  style: TextStyle(color: AppColors.secondaryColor),
                ),
              ),
              style: TextStyle(color: AppColors.primaryColor),
            ),
            const SizedBox(
              height: 8,
            ),
            TextField(
              controller: genres,
              decoration: const InputDecoration(
                label: Text(
                  'Genre',
                  style: TextStyle(color: AppColors.secondaryColor),
                ),
              ),
              style: TextStyle(color: AppColors.primaryColor),
            ),
            const SizedBox(
              height: 8,
            ),
            TextField(
              controller: price,
              decoration: const InputDecoration(
                label: Text(
                  'Price',
                  style: TextStyle(color: AppColors.secondaryColor),
                ),
              ),
              style: TextStyle(color: AppColors.primaryColor),
            ),
            const SizedBox(
              height: 8,
            ),
            TextField(
              controller: book_path,
              keyboardType: TextInputType.url,
              decoration: const InputDecoration(
                label: Text(
                  'Image Path',
                  style: TextStyle(color: AppColors.secondaryColor),
                ),
              ),
              style: TextStyle(color: AppColors.primaryColor),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.12,
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
                        rippleColor: AppColors.accentColor,
                        hoverColor: AppColors.accentColor,
                        tabBackgroundColor: AppColors.accentColor,
                        gap: 8,
                        activeColor: AppColors.secondaryColor,
                        iconSize: 24,
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                        duration: Duration(milliseconds: 400),
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
                          if (index == 0) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Categories()),
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
      ),
    );
  }
}

class Edit extends StatefulWidget {
  final Book b;

  Edit(this.b);

  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  TextEditingController name = TextEditingController();
  TextEditingController author = TextEditingController();
  TextEditingController rating = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController genres = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController book_path = TextEditingController();

  Future editStudent() async {
    var response = await http.post(
      Uri.parse("https://mostafamohammadi.liara.run/update.php"),
      body: {
        "id": widget.b.id.toString(),
        "name": name.text,
        "author": author.text,
        "rating": rating.text,
        "description": description.text,
        "genres": genres.text,
        "price": price.text,
        "book_path": book_path.text,
      },
    );
    return response;
  }

  @override
  void initState() {
    name = TextEditingController(text: widget.b.name);
    author = TextEditingController(text: widget.b.author);
    rating = TextEditingController(text: widget.b.rating);
    description = TextEditingController(text: widget.b.description);
    genres = TextEditingController(text: widget.b.genres);
    price = TextEditingController(text: widget.b.price);
    book_path = TextEditingController(text: widget.b.book_path);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.accentColor,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      bottomNavigationBar: BottomAppBar(
        color: AppColors.accentColor,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors
                .secondaryColor, // Change this to your preferred background color
          ),
          child: Text(
            'CONFIRM',
            style: TextStyle(color: AppColors.primaryColor),
          ),
          onPressed: () async {
            await editStudent();
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) {
              return BookDetails(
                data: widget.b,
              );
            }), (route) => false);
          },
        ),
      ),
      backgroundColor: AppColors.accentColor,
      body: Container(
        height: double.infinity,
        padding: EdgeInsets.all(20),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              children: <Widget>[
                TextField(
                  controller: name,
                  decoration: const InputDecoration(
                    label: Text('Book Name'),
                  ),
                  style: TextStyle(color: AppColors.primaryColor),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  controller: author,
                  decoration: const InputDecoration(
                    label: Text('Author Name'),
                  ),
                  style: TextStyle(color: AppColors.primaryColor),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  controller: rating,
                  decoration: const InputDecoration(
                    label: Text('Rating'),
                  ),
                  style: TextStyle(color: AppColors.primaryColor),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  controller: description,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    label: Text('Description'),
                  ),
                  style: TextStyle(color: AppColors.primaryColor),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  controller: genres,
                  decoration: const InputDecoration(
                    label: Text('Genre'),
                  ),
                  style: TextStyle(color: AppColors.primaryColor),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  controller: price,
                  decoration: const InputDecoration(
                    label: Text('Price'),
                  ),
                  style: TextStyle(color: AppColors.primaryColor),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  controller: book_path,
                  keyboardType: TextInputType.url,
                  decoration: const InputDecoration(
                    label: Text('Image Path'),
                  ),
                  style: TextStyle(color: AppColors.primaryColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
