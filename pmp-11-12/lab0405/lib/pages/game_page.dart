import 'package:flutter/material.dart';
import '../game.dart';
import '../game_sevice.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final GameService _gameService = GameService();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  void _showDialog({Game? game}) {
    if (game != null) {
      _nameController.text = game.name;
      _priceController.text = game.price.toString();
    } else {
      _nameController.clear();
      _priceController.clear();
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(game == null ? 'Add Game' : 'Edit Game'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Price'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final name = _nameController.text;
              final price = double.tryParse(_priceController.text) ?? 0.0;
              if (game == null) {
                _gameService.createGame(Game(
                  id: DateTime.now().toIso8601String(),
                  name: name,
                  price: price,
                ));
              } else {
                _gameService.updateGame(Game(
                  id: game.id,
                  name: name,
                  price: price,
                ));
              }
              Navigator.of(context).pop();
            },
            child: Text(game == null ? 'Add' : 'Update'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Games'),
      ),
      body: StreamBuilder<List<Game>>(
        stream: _gameService.getGames(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final games = snapshot.data!;
          return ListView.builder(
            itemCount: games.length,
            itemBuilder: (context, index) {
              final game = games[index];
              return ListTile(
                title: Text(game.name),
                subtitle: Text('\$${game.price.toStringAsFixed(2)}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => _showDialog(game: game),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _gameService.deleteGame(game.id),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
