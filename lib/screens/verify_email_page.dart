import 'package:cash_wise2/main.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  final _tokenController = TextEditingController();
  final _focusNode = FocusNode();
  String _message = '';
  bool _isLoading = false;

  Future<void> _verifyToken() async {
    final token = _tokenController.text.trim();
    if (token.isEmpty) {
      setState(() {
        _message = 'Please enter the token.';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _message = '';
    });

    try {
      final response = await Supabase.instance.client.auth.verifyOTP(
        token: token,
        type: OtpType.signup,
      );
        } on AuthException catch(e){
      if (mounted) context.showSnackBar(e.message, isError: true);
    } catch (e) {
      setState(() {
        _message = 'An error occurred: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _tokenController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Email'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _tokenController,
              focusNode: _focusNode,
              decoration: const InputDecoration(
                labelText: 'Enter verification token',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) => _verifyToken(),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _isLoading ? null : _verifyToken,
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Verify'),
            ),
            const SizedBox(height: 16.0),
            Text(
              _message,
              style: TextStyle(
                color: _message.contains('successfully') ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

