import 'dart:async';
import 'package:cash_wise2/screens/main_screen.dart';
import 'package:cash_wise2/screens/signup_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';
import '../main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
bool _isLoading = false;

late final TextEditingController _passwordController = TextEditingController();
late final TextEditingController _emailController = TextEditingController();
late final StreamSubscription<AuthState> _authStateSubscription;

Future<void> _signIn() async{
  try {
    setState(() {
      _isLoading = true;
    });
    await supabase.auth.signInWithPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );
    if (mounted) {
      context.showSnackBar('Logged in successfully!');
      _emailController.clear();
      _passwordController.clear();
    }
  } on AuthException catch (error) {
    if (mounted) context.showSnackBar(error.message, isError: true);
  } catch (error) {
    if (mounted) {
      context.showSnackBar('Unexpected error occurred', isError: true);
    }
  } finally {
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }
}

@override
void initState() {
  _authStateSubscription = supabase.auth.onAuthStateChange.listen(
        (data) {
      final session = data.session;
      if (session != null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MainScreen()),
        );
      }
    },
    onError: (error) {
      if (error is AuthException) {
        context.showSnackBar(error.message, isError: true);
      } else {
        context.showSnackBar('Unexpected error occurred', isError: true);
      }
    },
  );
  super.initState();
}

@override
void dispose() {
  _emailController.dispose();
  _passwordController.dispose();
  _authStateSubscription.cancel();
  super.dispose();
}

@override
Widget build(BuildContext context) {

  return Scaffold(
    appBar: AppBar(title: const Text('Sign In')),
    body: ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const SizedBox(height: 18),
        TextFormField(
          controller: _emailController,
          decoration: const InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
            contentPadding: EdgeInsets.all(10),
          ),
        ),
        const SizedBox(height: 20),
        TextFormField(
          controller: _passwordController,
          decoration: const InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
            contentPadding: EdgeInsets.all(10),
          ),
        ),
        const SizedBox(height: 18),
        ElevatedButton(
          onPressed: _isLoading ? null : _signIn,
          child: Text(_isLoading ? 'Signing In...' : 'Sign In'),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Don't have an account?"),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const SignUpScreen()),
                );
              },
              child: const Text('Sign Up'),
            ),
          ],
        ),
        SupaSocialsAuth(
          socialProviders: const [
            OAuthProvider.apple,
            OAuthProvider.google,
            OAuthProvider.facebook,
          ],
          colored: true,
          redirectUrl: kIsWeb
              ? null
              : 'com.cashwise://login-callback/',
          onSuccess: (Session response) {},
          onError: (error) {},
        )
      ],
    ),
  );
}
}