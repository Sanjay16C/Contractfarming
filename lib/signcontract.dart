import 'package:flutter/material.dart';

class SignContractPage extends StatefulWidget {
  final String contractName; // Contract name that the user is signing

  const SignContractPage({super.key, required this.contractName});

  @override
  _SignContractPageState createState() => _SignContractPageState();
}

class _SignContractPageState extends State<SignContractPage> {
  final TextEditingController _quotePriceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _gstNumberController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  DateTime? _selectedDeliveryDate;

  String? _selectedPaymentOption;

  void _selectDeliveryDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDeliveryDate = pickedDate;
      });
    }
  }

  void _signContract(BuildContext context) {
    if (_usernameController.text.isNotEmpty &&
        _quotePriceController.text.isNotEmpty &&
        _selectedPaymentOption != null &&
        _selectedDeliveryDate != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Contract Signed'),
            content: const Text('Contract signed successfully!'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  Navigator.of(context).pop(); // Return to the Cart Page
                },
              ),
            ],
          );
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all required fields'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Sign Contract for ${widget.contractName}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Contract Name
            Text(
              'You are going to sign a contract for: ${widget.contractName}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // Quote Price Field
            TextField(
              controller: _quotePriceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Quote Price',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Description Field
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Enter Description',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // GST Number Field
            TextField(
              controller: _gstNumberController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'GST Number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Payment Options Dropdown
            DropdownButtonFormField<String>(
              value: _selectedPaymentOption,
              items: ['Credit Card', 'Debit Card', 'Net Banking', 'UPI']
                  .map((String option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedPaymentOption = value;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Select Payment Option',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Delivery Date Picker
            InkWell(
              onTap: () => _selectDeliveryDate(context),
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Select Delivery Date',
                  border: OutlineInputBorder(),
                ),
                child: Text(
                  _selectedDeliveryDate == null
                      ? 'No Date Chosen'
                      : '${_selectedDeliveryDate!.day}/${_selectedDeliveryDate!.month}/${_selectedDeliveryDate!.year}',
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Username Authentication Field
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Enter Username to Authenticate',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Sign Contract Button
            ElevatedButton(
              onPressed: () => _signContract(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: const Text(
                'Sign Contract',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
