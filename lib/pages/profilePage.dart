import 'package:cash_wise2/pages/loginPage.dart';
import 'package:flutter/material.dart';
import '../main.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // get current user
  late final session = supabase.auth.currentSession!;


  Future<void> _signOut() async {
    try {
      await supabase.auth.signOut();
    } catch (error) {
      context.showSnackBar('Error signing out: ${error.toString()}', isError: true);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body:  Column(
        children: <Widget>[
          const SizedBox(height: 20),
          const CircleAvatar(
            radius: 70,
            backgroundImage: AssetImage('assets/images/profile.jpg'),
          ),
          const SizedBox(height: 20),
           Text(
            session.user.email!,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: () {
              _signOut();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
            child: const Text('Sign Out'),
          ),
      ],
      ),
    );
  }
}