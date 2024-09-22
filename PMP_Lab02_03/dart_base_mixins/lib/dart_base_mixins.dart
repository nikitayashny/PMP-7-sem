import 'dart:convert';
import 'dart:async';

mixin Organic {
  void isOrganic() {
    print('This food is organic.');
  }
}

// interface
abstract class Edible {
  void eat();
}

abstract class Food {
  String _name;
  double _price;

  Food(this._name, this._price);

  String get name => _name;
  set name(String value) => _name = value;

  double get price => _price;
  set price(double value) {
    if (value < 0) {
      throw Exception('Price cannot be negative');
    }
    _price = value;
  }

  void describe();
  void prepare();
  void serve();
}

class Fruit extends Food with Organic implements Comparable<Fruit>, Edible {
  String _color;
  static int fruitCount = 0;

  Fruit(String name, double price, this._color) : super(name, price) {
    fruitCount++;
  }

  String get color => _color;
  set color(String value) => _color = value;

  @override
  void describe() {
    print('Fruit: $name, Color: $color, Price: \$${price.toStringAsFixed(2)}');
  }

  @override
  void eat() {
    print('Eating $name.');
  }

  @override
  void prepare() {
    print('Preparing $name.');
  }

  @override
  void serve() {
    print('Serving $name.');
  }

  @override
  int compareTo(Fruit other) {
    return this.price.compareTo(other.price);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'color': color,
    };
  }

  // Функция с именованными параметрами и с параметрами по умолчанию
  void sale({int discount = 0}) {
    price -= discount.toDouble();
    print('$name is now \$${price.toStringAsFixed(2)} after discount.');
  }

  // Функция с параметром типа функция и с необязательным параметром
  void customAction(Function action, {String? message}) {
    action(this);
    if (message != null) {
      print(message);
    }
  }

  static void printCount() {
    print('Total fruits: $fruitCount');
  }
}

class Vegetable extends Food {
  bool _isLeafy;

  Vegetable(String name, double price, this._isLeafy) : super(name, price);

  bool get isLeafy => _isLeafy;
  set isLeafy(bool value) => _isLeafy = value;

  @override
  void describe() {
    print('Vegetable: $name, Leafy: $isLeafy, Price: \$${price.toStringAsFixed(2)}');
  }

  @override
  void prepare() {
    print('Preparing $name.');
  }

  @override
  void serve() {
    print('Serving $name.');
  }
}

class FruitCollection implements Iterable<Fruit> {
  final List<Fruit> _fruits = [];

  void add(Fruit fruit) {
    _fruits.add(fruit);
  }

  @override
  Iterator<Fruit> get iterator => FruitIterator(_fruits);

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class FruitIterator implements Iterator<Fruit> {
  final List<Fruit> _fruits;
  int _index = -1;

  FruitIterator(this._fruits);

  @override
  Fruit get current {
    if (_index < 0 || _index >= _fruits.length) {
      throw StateError('No current element');
    }
    return _fruits[_index];
  }

  @override
  bool moveNext() {
    _index++;
    return _index < _fruits.length;
  }
}

// Асинхронный метод
Future<void> fetchFruitData() async {
  await Future.delayed(const Duration(seconds: 2));
  print('Fetched fruit data');
}

// Single Subscription Stream
Stream<int> createSingleSubscriptionStream() async* {
  for (int i = 0; i < 5; i++) {
    await Future.delayed(const Duration(seconds: 1));
    yield i;
  }
}

// Broadcast Stream
void createBroadcastStream(StreamController<int> controller) {
  Timer.periodic(const Duration(seconds: 1), (timer) {
    if (timer.tick > 5) {
      timer.cancel();
      controller.close();
    } else {
      controller.add(timer.tick);
    }
  });
}

void main() async {
  List<Fruit> fruits = [
    Fruit('Apple', 1.0, 'Red'),
    Fruit('Banana', 0.5, 'Yellow'),
  ];

  Set<Vegetable> vegetables = {
    Vegetable('Carrot', 0.8, false),
    Vegetable('Spinach', 1.2, true),
  };

  Map<String, Food> foodMap = {
    'fruit1': fruits[0],
    'vegetable1': vegetables.first,
  };

  for (var fruit in fruits) {
    fruit.describe();
  }

  for (var vegetable in vegetables) {
    vegetable.describe();
  }

  FruitCollection fruitCollection = FruitCollection();
  fruitCollection.add(Fruit('Apple', 1.0, 'Red'));
  fruitCollection.add(Fruit('Banana', 0.5, 'Yellow'));

  for (var fruit in fruitCollection) {
    fruit.describe();
  }

  // continue и break
  for (var fruit in fruits) {
    if (fruit.price < 1.0) {
      continue;
    }
    print('Expensive fruit: ${fruit.name}');
  }

  try {
    Fruit fruit = Fruit('Mango', -1.0, 'Yellow');
    if (fruit.price < 0) {
      throw Exception('Price cannot be negative');
    }
  } catch (e) {
    print('Error: $e');
  }

  Fruit.printCount();

  // Асинхронный метод
  await fetchFruitData();

  print('Single Subscription Stream:');
  Stream<int> singleSubscriptionStream = createSingleSubscriptionStream();
  await for (var value in singleSubscriptionStream) {
    print('Single Subscription Stream Value: $value');
  }

  print('\nBroadcast Stream:');
  StreamController<int> broadcastController = StreamController<int>.broadcast();
  createBroadcastStream(broadcastController);

  broadcastController.stream.listen((value) {
    print('Listener 1: $value');
  });

  broadcastController.stream.listen((value) {
    print('Listener 2: $value');
  });

  await Future.delayed(const Duration(seconds: 6));
  await broadcastController.close();

  // Сериализация в JSON
  Fruit serializedFruit = Fruit('Apple', 1.0, 'Red');
  String jsonStr = jsonEncode(serializedFruit.toJson());
  print('Serialized fruit: $jsonStr');
}