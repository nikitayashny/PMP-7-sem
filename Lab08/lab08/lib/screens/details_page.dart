import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lab08/cart.dart';
import 'package:lab08/product.dart';
import 'package:lab08/user.dart';

class DetailsPage extends StatefulWidget {
  final int id;
  final User? currentUser;

  const DetailsPage({super.key, required this.id, required this.currentUser});

  @override
  DetailsPageState createState() => DetailsPageState();
}

class DetailsPageState extends State<DetailsPage> {
  final PageController _pageController = PageController();
  late TextEditingController nameController;
  late TextEditingController priceController;
  late Product product;

  @override
  void initState() {
    super.initState();
    _loadProduct();
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    super.dispose();
  }

  void _loadProduct() {
    final box = Hive.box<Product>('products');

    product = box.values.firstWhere((product) => product.id == widget.id);

    nameController = TextEditingController(text: product.productName);
    priceController = TextEditingController(text: product.price.toString());
    setState(() {});
  }

  int getLastCartId() {
    var box = Hive.box<CartItem>('cart');

    List<CartItem> cart = box.values.toList();

    int lastId = 0;
    for (var cartItem in cart) {
      if (cartItem.id > lastId) {
        lastId = cartItem.id;
      }
    }
    return lastId;
  }

  void _deleteProduct() {
    final box = Hive.box<Product>('products');
    box.delete(product.id);
    Navigator.pop(context);
  }

  void _editProduct() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newName = product.productName;
        double newPrice = product.price;

        return AlertDialog(
          title: const Text('Edit Product'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                onChanged: (value) {
                  newName = value;
                },
                decoration: const InputDecoration(labelText: 'Product Name'),
              ),
              TextField(
                controller: priceController,
                onChanged: (value) {
                  newPrice = double.tryParse(value) ?? product.price;
                },
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () {
                setState(() {
                  product.productName = newName;
                  product.price = newPrice;
                });

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (product == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Color.fromRGBO(24, 25, 43, 1),
        ),
        backgroundColor: Color.fromRGBO(24, 25, 43, 1),
        leading: const BackButton(
          color: Colors.white,
        ),
        elevation: 0,
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 22,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color.fromARGB(255, 232, 162, 9),
                      ),
                      child: const Text('SALE',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 30,
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 240,
                child: PageView(
                  controller: _pageController,
                  children: [
                    SizedBox(
                      child: Image.asset(
                        'src/assets/big_shoes02.png',
                        // Use id for dynamic image
                      ),
                    ),
                    SizedBox(
                      child: Image.asset(
                        'src/assets/big_shoes02.png',
                      ),
                    ),
                    SizedBox(
                      child: Image.asset(
                        'src/assets/big_shoes02.png',
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                        Icon(
                        Icons.people,
                        size: 40,
                        color: Colors.white,
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "10M",
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            Text(
                              "Followers",
                              style: TextStyle(color: Color.fromARGB(180, 255, 255, 255), fontSize: 14),
                            ),
                          ],
                        ),
                      ],),
                      Row(
                        children: [
                          Icon(
                            Icons.people_alt,
                            size: 40,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "50.6M",
                                style: TextStyle(color: Colors.white, fontSize: 16),
                              ),
                              Text(
                                "Players",
                                style: TextStyle(color: Color.fromARGB(180, 255, 255, 255), fontSize: 14),
                              ),
                            ],
                          ),
                        ],),
                      Row(
                        children: [
                          Icon(
                            Icons.wifi,
                            size: 40,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "1.8K",
                                style: TextStyle(color: Colors.white, fontSize: 16),
                              ),
                              Text(
                                "Streamers",
                                style: TextStyle(color: Color.fromARGB(180, 255, 255, 255), fontSize: 14),
                              ),
                            ],
                          ),
                        ],),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                      height: 7,
                      width: 50,
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(5)))
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(product.productName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      )),
                  ],
              ),
              if (widget.currentUser?.role.name == 'admin')
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: _editProduct,
                      color: Colors.white,
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: _deleteProduct,
                      color: Colors.white,
                    ),
                  ],
                ),
              const SizedBox(height: 10),
              Text(
                '${product.productName} is a free-to-play first-person hero shooter developed and published by ...',
                style: const TextStyle(
                  height: 1.6,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                'Size',
                style: TextStyle(
                  fontSize: 25,
                  color: Color.fromARGB(255, 0, 35, 63),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,

              ),

              const SizedBox(height: 10),
              Container(
                height: 80,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: 100,
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey.withOpacity(0.1),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            '\$',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            product.price.toString(),
                            style: const TextStyle(
                              fontSize: 30,
                              color: Color.fromARGB(255, 2, 55, 98),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 200,
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color.fromARGB(255, 2, 55, 98),
                      ),
                      child: TextButton(
                        onPressed: () {
                          if (widget.currentUser != null) {
                            final box = Hive.box<CartItem>('cart');
                            final exists = box.values.any((item) =>
                            item.productId == product.id && item.userName == widget.currentUser!.name);

                            if (!exists) {
                              final id = getLastCartId();
                              final cartItem = CartItem(id + 1, product.id, widget.currentUser!.name);

                              box.put(cartItem.id, cartItem);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Product added to cart')),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('This product is already in your cart')),
                              );
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Please log in to add products to cart')),
                            );
                          }
                        },
                        child: const Text(
                          '+ Add To Cart',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
