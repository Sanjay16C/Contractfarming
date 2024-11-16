import 'package:flutter/material.dart';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({super.key});

  @override
  _MyAccountPageState createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize with some example data
    _nameController.text = "John Doe";
    _phoneController.text = "+91 1234567890";
    _addressController.text = "123, Main Street, Chennai, India";
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Account'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Name',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your name',
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Phone Number',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: '+91',
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 20),
            const Text(
              'Address',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your address',
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle save or update action
                print(
                    'User Details Saved: ${_nameController.text}, ${_phoneController.text}, ${_addressController.text}');
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
