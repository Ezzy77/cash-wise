import 'package:cash_wise2/pages/loginPage.dart';
import 'package:cash_wise2/pages/mainPage.dart';
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
    home: supabase.auth.currentSession == null
        ? const LoginPage()
        : const MainPage(),
  ));
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