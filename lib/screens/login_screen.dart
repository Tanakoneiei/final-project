import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/main.dart';
import 'package:project/screens/create_account_screen.dart';
import 'package:project/services/auth_service.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  AuthService _service = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("สมุดรายชื่อเบอร์โทรศัพท์"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 100,
              backgroundImage: NetworkImage(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQli1KYQx8wP9qfcq1qfsV2BcJWSVHv5DKmRQ&usqp=CAU"),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
  controller: _emailController,
  decoration: InputDecoration(
    hintText: "อีเมล",
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    prefixIcon: Icon(Icons.email),
  ),
  style: TextStyle(fontSize: 18),
),
const SizedBox(
  height: 10,
),
TextField(
  controller: _passwordController,
  obscureText: true,
  decoration: InputDecoration(
    hintText: "รหัสผ่าน",
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    prefixIcon: Icon(Icons.lock),
  ),
  style: TextStyle(fontSize: 18),
),

            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                bool res = await _service.login(
                    _emailController.text, _passwordController.text);
                if (res) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("ลงชื่อเข้าใช้งานเรียบร้อยแล้ว")));

                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyHomePage(title: 'สมุดรายชื่อ')));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("อีเมลหรือรหัสผ่านไม่ถูกต้อง")));
                }
              },
              child: const Text(
                "เข้าสู่ระบบ",
                style: TextStyle(fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CreateAccountScreen()));
              },
              child: const Text(
                "สร้างบัญชีใหม่",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
