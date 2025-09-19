import 'package:flutter/material.dart';
import 'package:myapp/views/auth_screen/login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _retypePasswordController = TextEditingController();
  bool _agreeToTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6f4e37), Color(0xFFa1887f)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Image.asset('assets/icons/appIcon.png', height: 80),
                  const SizedBox(height: 20),
                  const Text(
                    'Join the Coffee Shop',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 30),
                  _buildSignupForm(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignupForm(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTextField('Name', _nameController, Icons.person_outline),
            const SizedBox(height: 20),
            _buildTextField(
              'Email',
              _emailController,
              Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            _buildTextField(
              'Password',
              _passwordController,
              Icons.lock_outline,
              isPassword: true,
            ),
            const SizedBox(height: 20),
            _buildTextField(
              'Retype Password',
              _retypePasswordController,
              Icons.lock_outline,
              isPassword: true,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Checkbox(
                  value: _agreeToTerms,
                  onChanged: (val) => setState(() => _agreeToTerms = val!),
                  activeColor: const Color(0xFF6f4e37),
                ),
                const Expanded(
                  child: Text(
                    'I agree to the Terms and Conditions & Privacy Policy',
                    style: TextStyle(color: Color(0xFF6f4e37)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildSignupButton(),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account?"),
                TextButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                  ),
                  child: const Text(
                    'Log in',
                    style: TextStyle(
                      color: Color(0xFF6f4e37),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller,
    IconData icon, {
    bool isPassword = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF6f4e37),
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: isPassword,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: const Color(0xFF6f4e37)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFF6f4e37)),
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) return '$label cannot be empty';
            if (label == 'Email' && !value.contains('@')) {
              return 'Invalid email';
            }
            if (label == 'Retype Password' &&
                value != _passwordController.text) {
              return 'Passwords do not match';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildSignupButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate() && _agreeToTerms) {
          // Call signup API
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF6f4e37),
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      child: const Text(
        'Sign up',
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _retypePasswordController.dispose();
    super.dispose();
  }
}
