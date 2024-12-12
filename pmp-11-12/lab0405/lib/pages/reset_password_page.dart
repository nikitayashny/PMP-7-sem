import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../auth.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  String? _errorMessage;

  Future<void> _resetPassword() async {
    try {
      await Auth().sendPasswordResetEmail(_emailController.text);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password reset email sent!')),
      );
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = e.message;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Enter your email to receive a password reset link:',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            if (_errorMessage != null) ...[
              const SizedBox(height: 10),
              Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            ],
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _resetPassword,
              child: const Text('Send Reset Link'),
            ),
          ],
        ),
      ),
    );
  }
}
