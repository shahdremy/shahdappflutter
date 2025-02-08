import 'package:flutter/material.dart';
import 'display_data_page.dart';

class EmailPasswordPage extends StatefulWidget {
  final String phoneOrEmail;
  final String firstName;
  final String lastName;
  final String birthDate;
  final String gender;

  EmailPasswordPage({
    required this.phoneOrEmail,
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    required this.gender,
  });

  @override
  _EmailPasswordPageState createState() => _EmailPasswordPageState();
}

class _EmailPasswordPageState extends State<EmailPasswordPage> {
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';

  void _register() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DisplayDataPage(
            email: email,
            password: password,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('إدخال البريد الإلكتروني وكلمة المرور')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextField(
                label: 'البريد الإلكتروني',
                icon: Icons.email,
                onSaved: (value) => email = value!,
              ),
              SizedBox(height: 16),
              _buildTextField(
                label: 'كلمة المرور',
                icon: Icons.lock,
                obscureText: true,
                onSaved: (value) => password = value!,
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: _register,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: Text('تسجيل', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required IconData icon,
    bool obscureText = false,
    required Function(String?) onSaved,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      obscureText: obscureText,
      onSaved: onSaved,
      validator: (value) => value!.isEmpty ? 'هذا الحقل مطلوب' : null,
    );
  }
}