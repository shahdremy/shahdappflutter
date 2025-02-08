import 'package:flutter/material.dart';

class FinalScreen extends StatelessWidget {
  final String email;
  final String password;
  final String phone;
  final String firstName;
  final String lastName;
  final String gender;
  final DateTime birthDate;

  FinalScreen({
    required this.email,
    required this.password,
    required this.phone,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.birthDate,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('التسجيل - تأكيد البيانات')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('البريد الإلكتروني: $email'),
            Text('كلمة المرور: $password'),
            Text('رقم الهاتف: $phone'),
            Text('الاسم الأول: $firstName'),
            Text('الاسم الأخير: $lastName'),
            Text('الجنس: $gender'),
            Text('تاريخ الميلاد: ${birthDate.toLocal()}'),
          ],
        ),
      ),
    );
  }
}