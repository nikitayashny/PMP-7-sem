import 'package:flutter/material.dart';
import 'second_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab_04_05',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(24, 25, 43, 1),
              Color.fromRGBO(76, 84, 146, 1),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 42.0, left: 14.0, right: 14.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Icon(
                      Icons.search,
                      size: 40,
                      color: Colors.white,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('welcome back', style: TextStyle(fontSize: 14, color: Color.fromARGB(180, 255, 255, 255))),
                        Text('@cat11', style: TextStyle(fontSize: 20, color: Colors.white)),
                      ],
                    ),
                    Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(right: 250),
                child: Text(
                  'Categories',
                  style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 60,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    'Action',
                    'Shooter',
                    'MOBA',
                    'Strategy',
                    'RPG',
                  ].map((category) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: ElevatedButton(
                        onPressed: () {
                          print("$category clicked");
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(140, 149, 145, 255),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(
                          category,
                          style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 14.0, left: 20.0, right: 14.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Trending Games', style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextButton(
                          onPressed: () {
                            print('See all clicked');
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size(0, 0),
                          ),
                          child: Text(
                            'See all',
                            style: TextStyle(fontSize: 14, color: Color.fromARGB(180, 255, 255, 255)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 320,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SecondScreen()),
                        );
                      },
                      child: buildImageCard('assets/images/valorant.jpg'),
                    ),
                    buildImageCard('assets/images/fortnite.png'),
                    buildImageCard('assets/images/overwatch.jpg'),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 14.0, left: 20.0, right: 14.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('New Games', style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextButton(
                          onPressed: () {
                            print('See all clicked');
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size(0, 0),
                          ),
                          child: Text(
                            'See all',
                            style: TextStyle(fontSize: 14, color: Color.fromARGB(180, 255, 255, 255)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              buildVerticalItem('assets/images/thelastofus.jpg', 'The Last Of Us Part I', 'Action - Adventure - Shooter'),
              buildVerticalItem('assets/images/thelastofus.jpg', 'The Last Of Us Part I', 'Action - Adventure - Shooter'),
              buildVerticalItem('assets/images/thelastofus.jpg', 'The Last Of Us Part I', 'Action - Adventure - Shooter'),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Positioned(
        child: Container(
          height: 70,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(24, 25, 43, 1),
            borderRadius: BorderRadius.only(
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.home, color: Colors.white),
                onPressed: () {
                  print('Home clicked');
                },
              ),
              IconButton(
                icon: Icon(Icons.search, color: Colors.white),
                onPressed: () {
                  print('Search clicked');
                },
              ),
              IconButton(
                icon: Icon(Icons.notifications, color: Colors.white),
                onPressed: () {
                  print('Notifications clicked');
                },
              ),
              IconButton(
                icon: Icon(Icons.favorite, color: Colors.white),
                onPressed: () {
                  print('Favorites clicked');
                },
              ),
              IconButton(
                icon: Icon(Icons.person, color: Colors.white),
                onPressed: () {
                  print('Profile clicked');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

  Widget buildImageCard(String imagePath) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      width: 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget buildVerticalItem(String imagePath, String title, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              imagePath,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                Text(
                  description,
                  style: TextStyle(fontSize: 16, color: Color.fromARGB(180, 255, 255, 255)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
}
