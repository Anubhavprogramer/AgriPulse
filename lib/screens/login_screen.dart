import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLogin = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  bool _loading = false;
  String? _error;

  Future<void> _handleAuth() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      if (_isLogin) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
      } else {
        if (_passwordController.text.trim() !=
            _confirmPasswordController.text.trim()) {
          setState(() {
            _error = "Passwords do not match";
          });
          return;
        }
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
      }
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomeScreen()),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        _error = e.message;
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Email
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter email' : null,
              ),
              SizedBox(height: 16),

              // Password
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) =>
                    value == null || value.length < 6 ? 'Min 6 chars' : null,
              ),
              SizedBox(height: 16),

              // Confirm Password (only for signup)
              if (!_isLogin)
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: InputDecoration(labelText: 'Confirm Password'),
                  obscureText: true,
                  validator: (value) {
                    if (!_isLogin && value != _passwordController.text) {
                      return "Passwords do not match";
                    }
                    return null;
                  },
                ),

              SizedBox(height: 24),

              // Error
              if (_error != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Text(_error!, style: TextStyle(color: Colors.red)),
                ),

              // Submit Button
              _loading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          _handleAuth();
                        }
                      },
                      child: Text(_isLogin ? 'Login' : 'Sign Up'),
                    ),

              // Toggle login/signup
              TextButton(
                onPressed: () => setState(() => _isLogin = !_isLogin),
                child: Text(
                    _isLogin ? 'No account? Sign Up' : 'Have account? Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
