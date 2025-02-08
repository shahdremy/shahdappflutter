import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'success_page.dart'; 
import 'register_page.dart'; 

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isDarkMode = false;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  void _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    });
  }

  void _toggleTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = !_isDarkMode;
      prefs.setBool('isDarkMode', _isDarkMode);
    });
  }

  Future<void> _login() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      setState(() {
        _errorMessage = "يرجى إدخال البريد الإلكتروني وكلمة المرور";
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2/health_blog_api/login.php'),
        body: {'email': email, 'password': password},
      );

      setState(() {
        _isLoading = false;
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['status'] == "success") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => SuccessPage()),
          );
        } else {
          setState(() {
            _errorMessage = data['message'];
          });
        }
      } else {
        setState(() {
          _errorMessage = "فشل الاتصال بالخادم";
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = "حدث خطأ أثناء تسجيل الدخول";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _isDarkMode ? Colors.black87 : Colors.blueGrey[50],
      appBar: AppBar(
        title: Text('تسجيل الدخول'),
        centerTitle: true,
        backgroundColor: _isDarkMode ? Colors.grey[900] : Colors.blue.shade600,
        actions: [
          IconButton(
            icon: Icon(_isDarkMode ? Icons.wb_sunny : Icons.nightlight_round),
            onPressed: _toggleTheme,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/photo.jpg', width: 300, height: 200, fit: BoxFit.cover),
              SizedBox(height: 20),
              _buildTextField(_emailController, 'البريد الإلكتروني', Icons.email),
              SizedBox(height: 10),
              _buildTextField(_passwordController, 'كلمة المرور', Icons.lock, obscureText: true),
              SizedBox(height: 20),
              _isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isDarkMode ? Colors.grey[800] : Colors.blue.shade600,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                      ),child: Text('تسجيل الدخول', style: TextStyle(fontSize: 18)),
                    ),
              if (_errorMessage != null) ...[
                SizedBox(height: 20),
                Text(_errorMessage!, style: TextStyle(color: Colors.red)),
              ],
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("ليس لديك حساب؟ "),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegistryPage()),
                      );
                    },
                    child: Text(
                      "إنشاء حساب",
                      style: TextStyle(
                        color: Colors.blue.shade600,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, {bool obscureText = false}) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: _isDarkMode ? Colors.white70 : Colors.blue.shade600),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        filled: true,
        fillColor: _isDarkMode ? Colors.grey[800] : Colors.white,
        labelStyle: TextStyle(color: _isDarkMode ? Colors.white70 : Colors.black),
      ),
      style: TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
    );
  }
}