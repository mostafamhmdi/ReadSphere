import 'package:flutter/material.dart';
import 'package:readsphere/data.dart';

void main() {
  getBooks();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          inputDecorationTheme:
              const InputDecorationTheme(border: OutlineInputBorder()),
          colorScheme:
              ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(
            secondary: const Color(0xff16E5A7),
          )),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Android Expert'),
      ),
      body: FutureBuilder<List<Book>>(
        future: getBooks(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return ListView.builder(
                padding: const EdgeInsets.only(bottom: 84),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return _Book(data: snapshot.data![index]);
                });
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class _Book extends StatelessWidget {
  final Book data;

  const _Book({Key? key, required this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 84,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.fromLTRB(8, 4, 8, 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(blurRadius: 10, color: Colors.black.withOpacity(0.05)),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            ),
            child: Text(
              data.name.characters.first,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w900,
                  fontSize: 24),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data.name),
                const SizedBox(
                  height: 8,
                ),
                Container(
                    padding: const EdgeInsets.fromLTRB(4, 2, 4, 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: Colors.grey.shade200,
                    ),
                    child: Text(
                      data.author,
                      style: const TextStyle(fontSize: 10),
                    ))
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.bar_chart_rounded,
                color: Colors.grey.shade400,
              ),
              Text(
                data.price.toString(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          )
        ],
      ),
    );
  }
}
