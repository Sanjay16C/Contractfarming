import 'package:flutter/material.dart';

/// =========================
///          PAGES
/// =========================

class SellPage extends StatefulWidget {
  const SellPage({super.key});

  @override
  _SellPageState createState() => _SellPageState();
}

class _SellPageState extends State<SellPage> {
  // List of items in My Listings
  final List<Map<String, dynamic>> _myListings = [
    {
      'name': 'Item 1',
      'type': 'Example Type 1',
      'price': 50,
    },
    {
      'name': 'Item 2',
      'type': 'Example Type 2',
      'price': 100,
    },
    {
      'name': 'Item 3',
      'type': 'Example Type 3',
      'price': 150,
    },
  ];

  // Function to add a new listing to the list
  void _addNewListing(Map<String, dynamic> listing) {
    setState(() {
      _myListings.add(listing);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            const Text(
              'My Listings',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20), // Space between title and item list

            // List of items
            Expanded(
              child: ListView.builder(
                itemCount: _myListings.length,
                itemBuilder: (context, index) {
                  final item = _myListings[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 4,
                          color: Colors.grey.shade300,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        // Item Icon
                        const Icon(
                          Icons.shopping_bag,
                          size: 48,
                          color: Colors.green,
                        ),
                        const SizedBox(
                            width: 16.0), // Space between icon and text
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['name'],
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Item Type: ${item['type']}',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                ),
                              ),
                              Text(
                                'Price: \$${item['price']}',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                        // More Info Button
                        TextButton(
                          onPressed: () {
                            // Handle more info action
                            print('More Info for ${item['name']}');
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.green, // Text color
                          ),
                          child: const Text('More Info'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(
                height:
                    20), // Space between item list and Create Listing section

            // Create Listing Section
            const Text(
              'Create Listing',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20), // Space between heading and options

            // New Proposal Option
            ElevatedButton(
              onPressed: () {
                // Navigate to the NewProposalPage and add the proposal to listings
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewProposalPage(
                      onCreateProposal: _addNewListing,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Colors.green, // Button color
              ),
              child: const Text('New Proposal'),
            ),
          ],
        ),
      ),
    );
  }
}

/// =========================
///    NEW PROPOSAL PAGE
/// =========================

class NewProposalPage extends StatelessWidget {
  final Function(Map<String, dynamic>) onCreateProposal;

  const NewProposalPage({super.key, required this.onCreateProposal});

  @override
  Widget build(BuildContext context) {
    final TextEditingController productNameController = TextEditingController();
    final TextEditingController productPriceController =
        TextEditingController();
    final TextEditingController productQuantityController =
        TextEditingController();
    final TextEditingController productDescriptionController =
        TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Create New Proposal'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Create a New Tender',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20), // Space between title and text fields

            // Product Name Field
            TextField(
              controller: productNameController,
              decoration: const InputDecoration(
                labelText: 'Product Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Product Price Field
            TextField(
              controller: productPriceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Product Price',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Product Quantity Field
            TextField(
              controller: productQuantityController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Product Quantity',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Product Description Field
            TextField(
              controller: productDescriptionController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Product Description',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Submit Button
            ElevatedButton(
              onPressed: () {
                // Handle New Proposal submission action
                final newListing = {
                  'name': productNameController.text,
                  'type': productDescriptionController.text,
                  'price': int.tryParse(productPriceController.text) ?? 0,
                };
                onCreateProposal(newListing);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Colors.green, // Button color
              ),
              child: const Text('Submit Proposal'),
            ),
          ],
        ),
      ),
    );
  }
}
