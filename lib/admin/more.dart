import 'package:bill/admin/login.dart';
import 'package:flutter/material.dart';

class More extends StatefulWidget {
  const More({super.key});

  @override
  State<More> createState() => _MoreState();
}

class _MoreState extends State<More> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome, Admin!",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: (){Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));},
              style: ElevatedButton.styleFrom(
                iconColor: Colors.red,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: const Text("Logout", style: TextStyle(fontSize: 18)),
            ),
          ],
        ),)
    );
  }
}