import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toko_online/data/dummy_data.dart';
import 'package:toko_online/providers/cart_provider.dart';
import 'package:toko_online/screens/cart_screen.dart';
import 'package:toko_online/screens/product_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Toko Online'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => CartScreen()),
              );
            },
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: dummyProducts.length,
        itemBuilder: (ctx, i) {
          final product = dummyProducts[i];
          return GridTile(
            footer: GridTileBar(
              backgroundColor: Colors.black87,
              title: Text(product.name, textAlign: TextAlign.center),
              trailing: IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Provider.of<CartProvider>(context, listen: false).addItem(product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Added item to cart!'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => ProductDetailScreen(product: product),
                  ),
                );
              },
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    Container(color: Colors.grey, child: const Icon(Icons.image_not_supported)),
              ),
            ),
          );
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
      ),
    );
  }
}
