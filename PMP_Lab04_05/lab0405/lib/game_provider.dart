import 'package:flutter/material.dart';
import 'game.dart';

class GameProvider with ChangeNotifier {
  List<Game> _games = [
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

  List<Game> get games => _games;

  void addGame(Game game) {
    _games.add(game);
    notifyListeners();
  }
}