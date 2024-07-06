import 'package:cash_wise2/screens/login_screen.dart';
import 'package:cash_wise2/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async{
  await dotenv.load(fileName: '.env');

  String? url = dotenv.env['SUPABASE_URL'];
  String? anonKey = dotenv.env['SUPABASE_ANON_KEY'];

  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: url!,
    anonKey: anonKey!,
    debug: true,

  );

  runApp(  MaterialApp(
    theme: ThemeData(
      primarySwatch: Colors.blue,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.black),
        bodyMedium: TextStyle(color: Colors.black),
        titleMedium: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      cardColor: Colors.grey[200],
      iconTheme: const IconThemeData(color: Colors.blue),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
      ),
    ),
    home: supabase.auth.currentSession == null
        ? const LoginScreen()
        : const MainScreen(),
  )
  );
}

final supabase = Supabase.instance.client;

extension ContextExtension on BuildContext {
  void showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError
            ? Theme.of(this).colorScheme.error
            : Theme.of(this).snackBarTheme.backgroundColor,
      ),
    );
  }
}