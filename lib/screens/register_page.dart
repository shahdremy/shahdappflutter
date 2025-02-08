import 'package:flutter/material.dart';
import 'email_password_page.dart';

class RegistryPage extends StatefulWidget {
  @override
  _RegistryPageState createState() => _RegistryPageState();
}

class _RegistryPageState extends State<RegistryPage> {
  final _formKey = GlobalKey<FormState>();

  String phoneOrEmail = '';
  String firstName = '';
  String lastName = '';
  String birthYear = '';
  String birthMonth = '';
  String birthDay = '';
  String gender = '';

  final List<String> months = [
    'يناير', 'فبراير', 'مارس', 'أبريل', 'مايو', 'يونيو',
    'يوليو', 'أغسطس', 'سبتمبر', 'أكتوبر', 'نوفمبر', 'ديسمبر'
  ];

  void _nextPage() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      String birthDate = "$birthYear-$birthMonth-$birthDay";

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EmailPasswordPage(
            phoneOrEmail: phoneOrEmail,
            firstName: firstName,
            lastName: lastName,
            birthDate: birthDate,
            gender: gender,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("تسجيل حساب جديد")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField('الهاتف أو البريد الإلكتروني', (value) => phoneOrEmail = value),
              _buildTextField('الاسم الأول', (value) => firstName = value),
              _buildTextField('الاسم الأخير', (value) => lastName = value),
              
              SizedBox(height: 16),
              Text('تاريخ الميلاد', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Row(
                children: [
                  Expanded(
                    child: _buildDropdownField(
                      'السنة',
                      List.generate(50, (index) => (1975 + index).toString()),
                      (value) => birthYear = value!,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: _buildDropdownField(
                      'الشهر',
                      months,
                      (value) => birthMonth = (months.indexOf(value!) + 1).toString().padLeft(2, '0'),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: _buildDropdownField(
                      'اليوم',
                      List.generate(31, (index) => (index + 1).toString().padLeft(2, '0')),
                      (value) => birthDay = value!,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 16),
              Text('الجنس', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildGenderOption('ذكر'),
                  SizedBox(width: 20),
                  _buildGenderOption('أنثى'),
                ],
              ),

              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _nextPage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // لون الزر
                  foregroundColor: Colors.white, // لون النص
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: Text('التالي', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, Function(String) onSaved) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onSaved: (value) => onSaved(value!),
        validator: (value) => value!.isEmpty ? 'هذا الحقل مطلوب' : null,
      ),
    );
  }

  Widget _buildDropdownField(String label, List<String> items, Function(String?) onSaved) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      items: items.map((String item) {
        return DropdownMenuItem(value: item, child: Text(item));
      }).toList(),
      onChanged: (value) {},
      onSaved: onSaved,
      validator: (value) => value == null ? 'الرجاء الاختيار' : null,
    );
  }

  Widget _buildGenderOption(String label) {
    return GestureDetector(
      onTap: () {
        setState(() => gender = label);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        decoration: BoxDecoration(
          color: gender == label ? Colors.blue : Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: gender == label ? Colors.white : Colors.black,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}