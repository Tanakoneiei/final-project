import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/screens/login_screen.dart';
import 'package:project/services/auth_service.dart';

class CreateAccountScreen extends StatelessWidget {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  AuthService _service = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("สร้างบัญชีผู้ใช้"),
        centerTitle: true, // จัดกึ่งกลาง
        leading: IconButton( // ไอคอนปุ่มย้อนกลับ
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                hintText: "อีเมล",
                prefixIcon: Icon(Icons.email), // ไอคอนอีเมล
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: "รหัสผ่าน",
                prefixIcon: Icon(Icons.lock), // ไอคอนล็อก
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                bool res = await _service.register(
                    _emailController.text, _passwordController.text);
                if (res) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("สร้างเสร็จสิ้น")));
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginScreen()));
                }
              },
              child: const Text("สร้างบัญชี"),
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 132, 98, 86), // เปลี่ยนสีปุ่ม
                shape: RoundedRectangleBorder( // กำหนดรูปทรงของปุ่ม
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
