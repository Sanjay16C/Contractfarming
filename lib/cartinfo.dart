import 'package:flutter/material.dart';
import 'cart.dart'; // Import Item model
import 'signcontract.dart'; // Import SignContractPage

/// CartInfoPage Widget which displays item details
class CartInfoPage extends StatelessWidget {
  final Item item;

  const CartInfoPage({super.key, required this.item});

  /// Shows a SnackBar for the Call button
  void _showCallSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Call functionality coming soon!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Contract Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Contract Name
            Text(
              item.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            // Contract Description
            Text(
              'Description: ${item.description}',
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Call Button
            Expanded(
              child: TextButton.icon(
                onPressed: () => _showCallSnackBar(context),
                icon: const Icon(Icons.phone, color: Colors.blue),
                label: const Text(
                  'Call',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
            // Sign Contract Button
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          SignContractPage(contractName: item.name),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                child: const Text(
                  'Sign Contract',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
