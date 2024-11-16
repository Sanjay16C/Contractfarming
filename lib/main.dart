import 'package:flutter/material.dart';
import 'buy.dart' as buy; // Prefix to avoid naming conflicts
import 'sell.dart' as sell; // Prefix to avoid naming conflicts
import 'dashboard.dart' as dashboard; // Prefix to avoid naming conflicts
import 'cart.dart'; // Import cart functionalities
import 'account.dart'; // Import MyAccountPage
import 'home.dart'; // Import HomePage
import 'buyinfo.dart'; // Import BuyInfoPage
import 'splash.dart'; // Import SplashPage
import 'login.dart'; // Import LoginPage
// Import RegisterPage
// Import ForgotPasswordPage

void main() {
  runApp(const MyApp());
}

/// =========================
///          MAIN
/// =========================

/// Main App Widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AgroChain',
      theme: ThemeData(
        primarySwatch: Colors.green,
        buttonTheme: const ButtonThemeData(
          buttonColor: Colors.green, // Buttons are green by default
          textTheme:
              ButtonTextTheme.primary, // Make text white on green buttons
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const SplashPage(), // Start with the SplashPage
    );
  }
}

/// =========================
///       MAIN HOME PAGE
/// =========================

class MainHomePage extends StatefulWidget {
  const MainHomePage({super.key});

  @override
  _MainHomePageState createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  int _selectedIndex = 0;
  List<Item> cart = []; // Cart list

  /// Function to add item to cart
  void _addItemToCart(String name, String description) {
    setState(() {
      cart.add(Item(name: name, description: description));
    });
  }

  /// Function to remove item from cart
  void _removeItemFromCart(Item item) {
    setState(() {
      cart.remove(item);
    });
  }

  /// Handle BottomNavigationBar item taps
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  /// Build content based on selected BottomNavigationBar item
  Widget _buildPageContent() {
    switch (_selectedIndex) {
      case 0:
        return const HomePage(); // Use the new HomePage for home content
      case 1:
        return buy.BuyPage(
          onProductTap: (product) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BuyInfoPage(
                  product: product,
                  onAddToCart: _addItemToCart,
                ),
              ),
            );
          },
        ); // Buy content
      case 2:
        return const sell.SellPage(); // Sell content
      case 3:
        return const dashboard.DashboardPageContent(); // Dashboard content
      case 4:
        return CartPage(
          cart: cart,
          onRemoveItem: _removeItemFromCart,
        ); // Cart content using CartPage
      default:
        return const HomePage(); // Default to home content
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('AgroChain'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: Text(
                'AgroChain',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text('My Account'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyAccountPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.location_on),
              title: const Text('Address'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('Help Centre'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Sign Out'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: _buildPageContent(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket),
            label: 'Buy',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sell),
            label: 'Sell',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
      ),
    );
  }
}
