import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:project/services/item_service.dart';

class NewItemScreen extends StatefulWidget {
  @override
  State<NewItemScreen> createState() => _NewItemScreenState();
}

class _NewItemScreenState extends State<NewItemScreen> {
  final _itemName = TextEditingController();
  final _itemPhone = TextEditingController();

  final ItemService _itemService = ItemService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("เพิ่มรายชื่อเบอร์โทรศัพท์"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _itemPhone,
              decoration: InputDecoration(
                labelText: "เบอร์โทร",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _itemName,
              decoration: InputDecoration(
                labelText: "ชื่อ",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
    onPressed: _addItem,
    icon: Icon(Icons.add),
    label: Text("เพิ่มข้อมูล"),
  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _addItem() async {
    if (_itemName.text.isEmpty || _itemPhone.text.isEmpty) return;

    await FirebaseFirestore.instance.collection("items").add({
      "name": _itemName.text,
      "phone": _itemPhone.text,
    });

    //แสดงสถานนะ
    showDialog( 
      context: context,
      builder: (context) => AlertDialog(
        title: Text("เพิ่มข้อมูลเรียบร้อยแล้ว"),
        content: Text("ข้อมูลของท่านได้ถูกเพิ่มแล้ว"),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: Text("ตกลง"),
          ),
        ],
      ),
    );

    _itemName.clear();
    _itemPhone.clear();
  }
}
