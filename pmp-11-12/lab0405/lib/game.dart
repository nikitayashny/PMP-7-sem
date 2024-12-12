class Game {
  final String id;
  final String name;
  final double price;

  Game({required this.id, required this.name, required this.price});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
    };
  }

  factory Game.fromMap(Map<String, dynamic> map, String documentId) {
    return Game(
      id: documentId,
      name: map['name'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
    );
  }
}
