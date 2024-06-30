
import 'dart:async';

import 'package:cash_wise2/pages/homePage.dart';
import 'package:cash_wise2/pages/profilePage.dart';
import 'package:cash_wise2/pages/statsPage.dart';
import 'package:cash_wise2/pages/walletPage.dart';
import 'package:flutter/material.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';
import 'package:uni_links/uni_links.dart';


class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  final _pageOptions = [
    const HomePage(),
    const WalletPage(),
    const StatPage(),
    const ProfilePage(),
  ];

  // late StreamSubscription _sub;

  @override
  void initState() {
    super.initState();
    // initUniLinks();
  }

  // Future<void> initUniLinks() async {
  //   // This will handle the incoming deep link.
  //   _sub = linkStream.listen((String link) {
  //     _handleDeepLink(link);
  //       } as void Function(String? event)?, onError: (err) {
  //     // Handle errors.
  //     print('Error receiving link: $err');
  //   });
  // }

  // void _handleDeepLink(String link) {
  //   final uri = Uri.parse(link);
  //   if (uri.host == 'verifyemail') {
  //     final token = uri.queryParameters['token'];
  //     _verifyEmailToken(token!);
  //   }
  // }

  // void _verifyEmailToken(String token) async {
  //   // Here you would call your Supabase function to verify the token
  //   final response = await Supabase.instance.client.auth.verifyOTP(
  //     token: token,
  //     type: OtpType.signup,
  //   );
  //   }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Add this line
        backgroundColor: const Color.fromARGB(255,48, 55, 69),
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
        selectedItemColor: Colors.white54,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}