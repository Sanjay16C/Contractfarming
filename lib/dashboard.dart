import 'package:flutter/material.dart';

// Main Dashboard Page Content
class DashboardPageContent extends StatelessWidget {
  const DashboardPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const CropPricesPage(); // Embedding CropPricesPage into Dashboard
  }
}

// Crop Prices Page within the Dashboard
class CropPricesPage extends StatefulWidget {
  const CropPricesPage({super.key});

  @override
  _CropPricesPageState createState() => _CropPricesPageState();
}

class _CropPricesPageState extends State<CropPricesPage> {
  String selectedCropPurchases = ''; // No crop selected initially for purchases
  String pricePurchases = 'Select a crop'; // Default text for purchases
  String quotedPricePurchases = ''; // To display quoted price for purchases

  String selectedCropSold = ''; // No crop selected initially for sold
  String priceSold = 'Select a crop'; // Default text for sold
  String quotedPriceSold = ''; // To display quoted price for sold

  final Map<String, String> cropPrices = {
    'Paddy': '₹1000 per quintal',
    'Wheat': '₹750 per quintal',
  };

  final Map<String, String> cropImages = {
    'Paddy':
        'https://via.placeholder.com/150?text=Paddy', // Placeholder image for Paddy
    'Wheat':
        'https://via.placeholder.com/150?text=Wheat', // Placeholder image for Wheat
  };

  void fetchPrice(String crop, String section) {
    // Update the price and quoted price based on the selected crop
    setState(() {
      if (section == 'purchases') {
        pricePurchases = cropPrices[crop] ?? 'Price not available';
        quotedPricePurchases = cropPrices[crop] ?? '';
      } else if (section == 'sold') {
        priceSold = cropPrices[crop] ?? 'Price not available';
        quotedPriceSold = cropPrices[crop] ?? '';
      }
    });
  }

  double getPriceValue(String priceString) {
    return double.parse(
        priceString.replaceAll('₹', '').replaceAll(' per quintal', ''));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const CustomScrollPhysics(
          scrollSpeedFactor: 0.5), // Adjust scroll speed factor
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Your Purchases Section
          _buildSectionHeader(
              'Your Purchases', selectedCropPurchases, 'purchases'),
          const SizedBox(height: 20),
          _buildDropdown('Select crop', selectedCropPurchases, 'purchases'),
          const SizedBox(height: 20),
          if (selectedCropPurchases.isNotEmpty) ...[
            _buildCropDetails(
                selectedCropPurchases, pricePurchases, quotedPricePurchases),
            const SizedBox(height: 20),
          ],

          // Sold by You Section
          _buildSectionHeader('Sold by You', selectedCropSold, 'sold'),
          const SizedBox(height: 20),
          _buildDropdown('Select crop', selectedCropSold, 'sold'),
          const SizedBox(height: 20),
          if (selectedCropSold.isNotEmpty) ...[
            _buildCropDetails(selectedCropSold, priceSold, quotedPriceSold),
            const SizedBox(height: 20),
          ],
        ],
      ),
    );
  }

  Widget _buildSectionHeader(
      String title, String selectedCrop, String section) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        if (selectedCrop.isNotEmpty) ...[
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => fetchPrice(selectedCrop, section),
          ),
        ],
      ],
    );
  }

  Widget _buildDropdown(String hint, String selectedCrop, String section) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[400]!), // Border color
        color: Colors.white,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: Text(hint),
          value: selectedCrop.isEmpty ? null : selectedCrop,
          isExpanded: true,
          items: cropPrices.keys.map((String crop) {
            return DropdownMenuItem<String>(
              value: crop,
              child: Text(
                crop,
                style: const TextStyle(color: Colors.black), // Black text color
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              if (section == 'purchases') {
                selectedCropPurchases = newValue!;
                fetchPrice(selectedCropPurchases, section);
              } else if (section == 'sold') {
                selectedCropSold = newValue!;
                fetchPrice(selectedCropSold, section);
              }
            });
          },
        ),
      ),
    );
  }

  Widget _buildCropDetails(
      String selectedCrop, String livePrice, String quotedPrice) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[400]!), // Border color
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Crop image
          SizedBox(
            height: 150,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                cropImages[selectedCrop] ?? 'https://via.placeholder.com/150',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(child: Text('Image not available'));
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Details: quoted price and live price
          const Text(
            'Quoted Price:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            quotedPrice,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16),
          const Text(
            'Live Price:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  livePrice,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: getPriceValue(livePrice) < getPriceValue(quotedPrice)
                        ? Colors.red
                        : Colors.green, // Conditional color
                  ),
                ),
              ),
              Icon(
                getPriceValue(livePrice) < getPriceValue(quotedPrice)
                    ? Icons.arrow_downward
                    : Icons.arrow_upward,
                color: getPriceValue(livePrice) < getPriceValue(quotedPrice)
                    ? Colors.red
                    : Colors.green, // Conditional color
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Custom Scroll Physics to adjust scrolling speed
class CustomScrollPhysics extends ScrollPhysics {
  final double scrollSpeedFactor;

  const CustomScrollPhysics({this.scrollSpeedFactor = 1.0, super.parent});

  @override
  CustomScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return CustomScrollPhysics(
      scrollSpeedFactor: scrollSpeedFactor,
      parent: buildParent(ancestor),
    );
  }

  @override
  double applyPhysicsToUserOffset(ScrollMetrics position, double offset) {
    return offset * scrollSpeedFactor;
  }
}
