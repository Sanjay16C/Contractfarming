import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                // Trending News Section as a Container
                Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Trending📈',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 150,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics:
                              const BouncingScrollPhysics(), // Smooth scrolling
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return _buildNewsCard(
                              'News ${index + 1}',
                              'https://via.placeholder.com/150', // Placeholder image URL
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Advertisement Section
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.orange[200],
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                      image: NetworkImage(
                          'https://via.placeholder.com/600x150'), // Example ad image
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: InkWell(
                    onTap: () {
                      // Implement ad click behavior here
                    },
                    child: Container(
                      alignment: Alignment.center,
                      color: Colors.black.withOpacity(0.3),
                      child: const Text(
                        'Sponsored Ad',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Farm Products Section
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Products for you',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    _buildProductList(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Trending News Card Widget
  Widget _buildNewsCard(String title, String imageUrl) {
    return Container(
      width: 250,
      margin: const EdgeInsets.only(right: 10),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(10)),
                child: Image.network(
                  imageUrl,
                  height: 100,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Farm Products List
  Widget _buildProductList() {
    return Column(
      children: [
        _buildProductItem('Product 1', 'Description of Product 1', 100),
        const SizedBox(height: 10),
        _buildProductItem('Product 2', 'Description of Product 2', 200),
        const SizedBox(height: 10),
        _buildProductItem('Product 3', 'Description of Product 3', 150),
      ],
    );
  }

  // Farm Product Item Widget
  Widget _buildProductItem(String name, String description, double price) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            const Icon(Icons.agriculture, size: 50, color: Colors.green),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    description,
                    style: const TextStyle(fontSize: 14),
                  ),
                  Text(
                    '\$${price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
