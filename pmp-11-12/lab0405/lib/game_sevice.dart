import 'package:cloud_firestore/cloud_firestore.dart';
import 'game.dart';

class GameService {
  final CollectionReference _gamesCollection =
  FirebaseFirestore.instance.collection('games');

  // Create
  Future<void> createGame(Game game) async {
    await _gamesCollection.doc(game.id).set(game.toMap());
  }

  // Read 
  Stream<List<Game>> getGames() {
    return _gamesCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Game.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }

  // Update
  Future<void> updateGame(Game game) async {
    await _gamesCollection.doc(game.id).update(game.toMap());
  }

  // Delete
  Future<void> deleteGame(String id) async {
    await _gamesCollection.doc(id).delete();
  }
}
