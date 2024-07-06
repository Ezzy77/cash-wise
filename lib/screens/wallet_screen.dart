import 'package:flutter/material.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return  Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor,
        title: Text('Wallet',
          style: theme.textTheme.bodyLarge,
        ),
      ),
      body: const Center(
        child: Text('Wallet Screen'),
      ),
    );
  }
}