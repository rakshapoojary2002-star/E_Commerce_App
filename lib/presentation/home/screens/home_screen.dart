import 'package:e_commerce_app/presentation/cart/screens/cart_tab.dart';
import 'package:e_commerce_app/presentation/home/screens/home_tab.dart';
import 'package:e_commerce_app/presentation/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:e_commerce_app/presentation/cart/providers/cart_providers.dart';

class HomeScreen extends ConsumerStatefulWidget {
  final String token;
  const HomeScreen({super.key, required this.token});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _selectedIndex = 0;

  late final List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();
    _widgetOptions = <Widget>[HomeTab(), CartTab(), ProfileScreen()];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartItemCount = ref
        .watch(cartItemCountProvider)
        .when(data: (count) => count, loading: () => 0, error: (_, __) => 0);

    return Scaffold(
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Badge(
              label: Text(
                cartItemCount.toString(),
                style: const TextStyle(color: Colors.white),
              ),
              isLabelVisible: cartItemCount > 0,
              backgroundColor: Colors.red,
              child: const Icon(Icons.shopping_cart),
            ),
            label: 'Cart',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).colorScheme.onSurface,
      ),
    );
  }
}
