import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductList(),
    );
  }
}

class Product {
  final String name;
  final double price;
  int counter;

  Product({required this.name, required this.price, this.counter = 0});

  void incrementCounter() => counter++;
}

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<Product> products = [
    Product(name: 'iPhone', price: 999),
    Product(name: 'MacBook Pro', price: 1999),
    Product(name: 'iMac', price: 2399),
    Product(name: 'iWatch', price: 399),
    Product(name: 'iPad', price: 500),
    Product(name: 'Mac Pro', price: 4999),
    Product(name: 'EarPod', price: 500),
    Product(name: 'EarPod Pro', price: 500),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
        backgroundColor: Color.fromARGB(255, 9, 34, 22),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => CartPage()));
        },
        backgroundColor: Color.fromARGB(255, 9, 34, 22),
        child: const Icon(Icons.shopping_cart),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) => Container(
          decoration: BoxDecoration(
            border:
                Border.all(color: Color.fromARGB(255, 9, 34, 22), width: 0.3),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListTile(
            title: Text(
              products[index].name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              '\$${products[index].price.toStringAsFixed(2)}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: CounterButton(
              product: products[index],
              onCounterUpdated: _showDialogIfLimitReached,
            ),
          ),
        ),
      ),
    );
  }

  void _showDialogIfLimitReached(Product product) {
    if (product.counter == 5) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Congratulations!'),
            content: Text('You\'ve bought 5 ${product.name}!'),
            actions: <Widget>[
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 9, 34, 22)),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}

class CounterButton extends StatefulWidget {
  final Product product;
  final Function(Product) onCounterUpdated;

  const CounterButton(
      {Key? key, required this.product, required this.onCounterUpdated})
      : super(key: key);

  @override
  State<CounterButton> createState() => _CounterButtonState();
}

class _CounterButtonState extends State<CounterButton> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Column(
          children: [
            Text('Counter ${widget.product.counter}'),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromARGB(255, 9, 34, 22)),
              ),
              onPressed: () {
                setState(() {
                  widget.product.incrementCounter();
                  totalSell++;
                  widget.onCounterUpdated(widget.product);
                });
              },
              child: const Text('Buy Now'),
            ),
          ],
        ),
      ],
    );
  }
}

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        backgroundColor: Color.fromARGB(255, 9, 34, 22),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'Total Products: $totalSell',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

int totalSell = 0;
