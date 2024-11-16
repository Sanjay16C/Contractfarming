import 'package:flutter/material.dart';
import 'cartinfo.dart'; // Import CartInfoPage

/// Item model to use within the cart
class Item {
  final String name;
  final String description;

  Item({required this.name, required this.description});
}

/// CartPage Widget which handles the cart functionality
class CartPage extends StatelessWidget {
  final List<Item> cart;
  final Function(Item) onRemoveItem;

  const CartPage({super.key, required this.cart, required this.onRemoveItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: cart.isEmpty
          ? const Center(
              child: Text(
                'Your cart is empty!',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: cart.length,
              itemBuilder: (context, index) {
                final item = cart[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartInfoPage(item: item),
                      ),
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 16.0,
                    ),
                    elevation: 4,
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(
                          item.name[0]
                              .toUpperCase(), // Display first character of the item name
                        ),
                      ),
                      title: Text(item.name),
                      subtitle: Text(item.description),
                      trailing: IconButton(
                        icon: const Icon(Icons.remove_shopping_cart,
                            color: Colors.red),
                        onPressed: () => onRemoveItem(item),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
