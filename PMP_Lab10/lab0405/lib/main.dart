import 'package:flutter/material.dart';
import 'game.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'game_bloc.dart';
import 'game_event.dart';
import 'game_state.dart';
import 'second_screen.dart';

final List<Game> games = [
  Game(
    image: "assets/images/valorant.jpg",
    name: "Valorant",
    followers: "10M",
    players: "50.6M",
    streamers: "1.8K",
    article: "Valorant is a free-to-play first-person hero shooter developed and published by ...",
  ),
  Game(
    image: "assets/images/fortnite.png",
    name: "Fortnite",
    followers: "12M",
    players: "42.7M",
    streamers: "1.6K",
    article: "Fortnite is a free-to-play first-person hero shooter developed and published by ...",
  ),
  Game(
    image: "assets/images/overwatch.jpg",
    name: "Overwatch",
    followers: "15M",
    players: "23.6M",
    streamers: "8.1K",
    article: "Overwatch is a free-to-play first-person hero shooter developed and published by ...",
  ),
];

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
      home: BlocProvider(
        create: (context) => GameBloc(games)..add(LoadGames()),
        child: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

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
        child: BlocBuilder<GameBloc, GameState>(
          builder: (context, state) {
            if (state is GameLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is GameLoaded) {
              return _buildGameList(state.games, context);
            } else if (state is GameError) {
              return Center(child: Text(state.message));
            }
            return Container(); // Fallback for initial state
          },
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildGameList(List<Game> games, BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildCategories(),
          _buildTrendingGames(games, context),
          _buildNewGamesSection(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildCategories() {
    return Padding(
      padding: const EdgeInsets.only(right: 250),
      child: Text(
        'Categories',
        style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildTrendingGames(List<Game> games, BuildContext context) {
    return SizedBox(
      height: 320,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: games.map((game) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DescriptionPage(game: game)),
              );
            },
            child: buildImageCard(game.image),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildNewGamesSection() {
    return Padding(
      padding: const EdgeInsets.only(top: 14.0, left: 20.0, right: 14.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('New Games', style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold)),
              TextButton(
                onPressed: () {
                  print('See all clicked');
                },
                child: Text('See all', style: TextStyle(fontSize: 14, color: Color.fromARGB(180, 255, 255, 255))),
              ),
            ],
          ),
          buildVerticalItem('assets/images/thelastofus.jpg', 'The Last Of Us Part I', 'Action - Adventure - Shooter'),
          buildVerticalItem('assets/images/thelastofus.jpg', 'The Last Of Us Part I', 'Action - Adventure - Shooter'),
          buildVerticalItem('assets/images/thelastofus.jpg', 'The Last Of Us Part I', 'Action - Adventure - Shooter'),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      height: 70,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(24, 25, 43, 1),
        borderRadius: BorderRadius.only(),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.home, color: Colors.white),
            onPressed: () => print('Home clicked'),
          ),
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () => print('Search clicked'),
          ),
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.white),
            onPressed: () => print('Notifications clicked'),
          ),
          IconButton(
            icon: Icon(Icons.favorite, color: Colors.white),
            onPressed: () => print('Favorites clicked'),
          ),
          IconButton(
            icon: Icon(Icons.person, color: Colors.white),
            onPressed: () => print('Profile clicked'),
          ),
        ],
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