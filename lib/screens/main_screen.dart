import 'package:cash_wise2/screens/home_screen.dart';
import 'package:cash_wise2/screens/profile_screen.dart';
import 'package:cash_wise2/screens/stats_screen.dart';
import 'package:cash_wise2/screens/wallet_screen.dart';
import 'package:flutter/material.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final _pageOptions = [
    const HomeScreen(),
    const WalletScreen(),
    const StatsScreen(),
    const ProfilePage(),
  ];

  // late StreamSubscription _sub;

  @override
  void initState() {
    super.initState();
    // initUniLinks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Add this line
        backgroundColor:  Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wallet),
            label: 'Wallet',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart), // Choose an appropriate icon for your StatPage
            label: 'Stats', // Label it appropriately
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        // selectedItemColor: ,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}