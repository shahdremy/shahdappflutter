import 'package:flutter/material.dart';
import 'login_page.dart'; // استيراد الصفحة الرئيسية (تسجيل الدخول)

class SuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        title: Text('نجاح'),
        backgroundColor: Colors.blue.shade600,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.check_circle_outline,
              size: 100,
              color: const Color.fromARGB(255, 25, 234, 60),
            ),
            SizedBox(height: 20),
            Text(
              'تمت إضافة البيانات بنجاح!',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade600,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // العودة إلى صفحة تسجيل الدخول
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade600, // استخدام backgroundColor بدلاً من primary
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'عودة إلى تسجيل الدخول',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white, // تغيير اللون إلى الأبيض
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}