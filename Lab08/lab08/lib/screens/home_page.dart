import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lab08/screens/add_product.dart';
import 'package:lab08/user.dart';
import 'package:lab08/screens/users_screen.dart';
import 'package:hive/hive.dart';
import 'package:lab08/widgets/search_widget.dart';
import 'cart_page.dart';
import 'details_page.dart';
import 'package:lab08/product.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? currentUser;
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    loadCurrentUser();
    loadProducts();
  }

  void loadCurrentUser() async {
    var box = await Hive.openBox<User>('users');
    if (box.isNotEmpty) {
      setState(() {
        currentUser = box.getAt(0);
      });
    } else {
      setState(() {
        currentUser = null;
      });
    }
  }

  void loadProducts() async {
    var box = await Hive.openBox<Product>('products');
    setState(() {
      products = box.values.toList();
    });
  }

  showDetailScreen(int productId, String productName, String productPrice) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DetailsPage(id: productId, currentUser: currentUser),
      ),
    ).then((_) {
      loadProducts();
    });
  }

  void addProduct() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const AddProductPage(),
      ),
    ).then((_) {
      loadProducts();
    });
  }

  void switchUser() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => UserListPage(
          onUserSelected: (User user) {
            setState(() {
              currentUser = user;
            });
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Color.fromRGBO(24, 25, 43, 1),
        ),
        backgroundColor: Color.fromRGBO(24, 25, 43, 1),
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () => {},
              icon: const Icon(
                Icons.search,
                size: 40,
                color: Colors.white,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('welcome back', style: TextStyle(fontSize: 14, color: Color.fromARGB(180, 255, 255, 255))),
                Text('@cat11', style: TextStyle(fontSize: 20, color: Colors.white)),
              ],
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CartPage(userName: currentUser?.name ?? ''),
                  ),
                );
              },
              icon: const Icon(
                Icons.local_mall_outlined,
                color: Colors.white,
                size: 28,
              ),
            ),
          ],
        ),
      ),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
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
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextButton(
                onPressed: switchUser,
                child: Text(
                  'Current User: ${currentUser?.name ?? "Unknown"}',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            if (currentUser?.role.name == 'admin')
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextButton(
                  onPressed: addProduct,
                  child: const Text(
                    'Add Product',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

            SizedBox(
              height: 240,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Container (
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    height: 240,
                    child: Image.asset('src/assets/big_shoes02.png'),
                  ),
                  Container (
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    height: 240,
                    child: Image.asset('src/assets/big_shoes02.png'),
                  ),
                  Container (
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    height: 240,
                    child: Image.asset('src/assets/big_shoes02.png'),
                  ),
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
            const SizedBox(height: 20),

            const SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: products.map((product) {
                  return InkWell(
                    onTap: () {
                      showDetailScreen(product.id, product.productName, product.price.toString());
                    },
                    child: Column(
                      children: [
                        SizedBox(
                          height: 200,
                          child: Stack(
                            children: [
                              Positioned(
                                child: Container(
                                  margin: const EdgeInsets.only(
                                    left: 20,
                                    top: 20,
                                  ),
                                  height: 200,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(255, 2, 55, 98),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 45,
                                left: 40,
                                child: SizedBox(
                                  width: 120,
                                  child: Image.asset(
                                    'src/assets/big_shoes02.png',
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 25,
                                child: Row(
                                  children: [
                                    Row(
                                      children: [
                                        const Text(
                                          '\$',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          product.price.toString(),
                                          style: const TextStyle(
                                            fontSize: 30,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(width: 50),
                                        const Icon(Icons.favorite, color: Colors.red)
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            product.productName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
