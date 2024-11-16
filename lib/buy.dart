import 'package:flutter/material.dart';
// Import BuyInfoPage

class BuyPage extends StatefulWidget {
  final Function(Map<String, String>) onProductTap;

  const BuyPage({super.key, required this.onProductTap});

  @override
  _BuyPageState createState() => _BuyPageState();
}

class _BuyPageState extends State<BuyPage> {
  final List<Map<String, String>> _products = [
    {
      'name': 'Product 1',
      'locality': 'Locality 1',
      'priceRange': '₹1000 - ₹1500',
      'image': 'https://via.placeholder.com/150'
    },
    {
      'name': 'Product 2',
      'locality': 'Locality 2',
      'priceRange': '₹1500 - ₹2000',
      'image': 'https://via.placeholder.com/150'
    },
    // Add more products as needed
  ];

  final List<Map<String, String>> _forYouProducts = [
    {
      'name': 'Sample Rice',
      'locality': 'Sample Locality 1',
      'priceRange': '₹500 - ₹1000',
      'image': 'https://via.placeholder.com/150'
    },
    {
      'name': 'Sample Wheat',
      'locality': 'Sample Locality 2',
      'priceRange': '₹1000 - ₹1500',
      'image': 'https://via.placeholder.com/150'
    },
    {
      'name': 'Sample Barley',
      'locality': 'Sample Locality 3',
      'priceRange': '₹800 - ₹1200',
      'image': 'https://via.placeholder.com/150'
    },
    {
      'name': 'Sample Corn',
      'locality': 'Sample Locality 4',
      'priceRange': '₹600 - ₹1100',
      'image': 'https://via.placeholder.com/150'
    },
    // Add more sample products as needed
  ];

  List<Map<String, String>> _displayedProducts = [];

  final List<String> _selectedCostFilters = [];
  final List<String> _selectedLocalityFilters = [];
  final List<String> _selectedCostRangeFilters = [];

  @override
  void initState() {
    super.initState();
    _displayedProducts = _products; // Initialize with all products
  }

  void _searchProducts(String query) {
    setState(() {
      if (query.isEmpty) {
        _displayedProducts = _products;
      } else {
        _displayedProducts = _forYouProducts.where((product) {
          return product['name']!.toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  void _applyFilters() {
    setState(() {
      _displayedProducts = _forYouProducts.where((product) {
        final costMatch = _selectedCostFilters.isEmpty ||
            _selectedCostFilters.contains(product['priceRange']);
        final localityMatch = _selectedLocalityFilters.isEmpty ||
            _selectedLocalityFilters.contains(product['locality']);
        final costRangeMatch = _selectedCostRangeFilters.isEmpty ||
            _selectedCostRangeFilters.contains(product['priceRange']);
        return costMatch && localityMatch && costRangeMatch;
      }).toList();
    });
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Filter'),
          content: SizedBox(
            width: 600,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFilterOption(
                    title: 'Cost',
                    options: ['₹500 - ₹1000', '₹1000 - ₹1500', '₹1500 - ₹2000'],
                    selectedOptions: _selectedCostFilters,
                    onChanged: (value, isChecked) {
                      setState(() {
                        if (isChecked) {
                          _selectedCostFilters.add(value);
                        } else {
                          _selectedCostFilters.remove(value);
                        }
                      });
                    },
                  ),
                  const Divider(),
                  _buildFilterOption(
                    title: 'Locality',
                    options: [
                      'Locality 1',
                      'Locality 2',
                      'Locality 3',
                      'Locality 4'
                    ],
                    selectedOptions: _selectedLocalityFilters,
                    onChanged: (value, isChecked) {
                      setState(() {
                        if (isChecked) {
                          _selectedLocalityFilters.add(value);
                        } else {
                          _selectedLocalityFilters.remove(value);
                        }
                      });
                    },
                  ),
                  const Divider(),
                  _buildFilterOption(
                    title: 'Cost Range',
                    options: ['₹500 - ₹1000', '₹1000 - ₹1500', '₹1500 - ₹2000'],
                    selectedOptions: _selectedCostRangeFilters,
                    onChanged: (value, isChecked) {
                      setState(() {
                        if (isChecked) {
                          _selectedCostRangeFilters.add(value);
                        } else {
                          _selectedCostRangeFilters.remove(value);
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _applyFilters();
              },
              child: const Text('Apply'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFilterOption({
    required String title,
    required List<String> options,
    required List<String> selectedOptions,
    required Function(String, bool) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        ...options.map((option) {
          return CheckboxListTile(
            title: Text(option),
            value: selectedOptions.contains(option),
            onChanged: (isChecked) => onChanged(option, isChecked!),
          );
        }),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search and Filter Icons in Row
            Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: _searchProducts,
                    decoration: const InputDecoration(
                      hintText: 'Search for products',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: _showFilterDialog,
                ),
                IconButton(
                  icon: const Icon(Icons.sort),
                  onPressed: () {
                    // Handle sorting dialog here if needed
                  },
                ),
              ],
            ),
            const SizedBox(height: 16.0),

            // Product Listings
            Expanded(
              child: ListView.builder(
                itemCount: _displayedProducts.isEmpty
                    ? _forYouProducts.length
                    : _displayedProducts.length,
                itemBuilder: (context, index) {
                  final product = _displayedProducts.isEmpty
                      ? _forYouProducts[index]
                      : _displayedProducts[index];
                  return GestureDetector(
                    onTap: () {
                      widget.onProductTap(product);
                    },
                    child: Card(
                      margin: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 16.0,
                      ),
                      elevation: 4,
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(8.0),
                        leading: Image.network(
                          product['image']!,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.broken_image,
                              size: 80,
                              color: Colors.grey,
                            );
                          },
                        ),
                        title: Text(product['name']!),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${product['locality']}'),
                            const SizedBox(height: 4.0),
                            Text('${product['priceRange']}'),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
