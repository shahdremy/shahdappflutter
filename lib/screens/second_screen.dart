import 'package:flutter/material.dart';
import 'final_screen.dart';

class SecondScreen extends StatefulWidget {
  final String phone;
  final String firstName;
  final String lastName;
  final String gender;
  final DateTime birthDate;

  SecondScreen({
    required this.phone,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.birthDate,
  });

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  void _goToFinalScreen() {
    if (_passwordController.text == _confirmPasswordController.text) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FinalScreen(
            email: _emailController.text,
            password: _passwordController.text,
            phone: widget.phone,
            firstName: widget.firstName,
            lastName: widget.lastName,
            gender: widget.gender,
            birthDate: widget.birthDate,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('كلمات المرور غير متطابقة')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('التسجيل - بيانات الحساب')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'البريد الإلكتروني'),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'كلمة المرور'),
            ),
            TextField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'تأكيد كلمة المرور'),
            ),
            ElevatedButton(
              onPressed: _goToFinalScreen,
              child: Text('إرسال'),
            ),
          ],
        ),
      ),
    );
  }
}