import 'package:flutter/material.dart';

class BuyInfoPage extends StatelessWidget {
  final Map<String, String> product;
  final Function(String, String) onAddToCart; // Callback to add to cart

  const BuyInfoPage({
    super.key,
    required this.product,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Product Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              product['image']!,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.broken_image,
                  size: 200,
                  color: Colors.grey,
                );
              },
            ),
            const SizedBox(height: 20),
            Text(
              product['name']!,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Locality: ${product['locality']}',
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            Text(
              'Price Range: ${product['priceRange']}',
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            // Add item to cart using the callback function
            onAddToCart(product['name']!, product['locality']!);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Product added to cart'),
                duration: Duration(seconds: 2),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 15),
          ),
          child: const Text(
            'Add to Cart',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
