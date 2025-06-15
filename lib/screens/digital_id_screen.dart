import 'package:flutter/material.dart';

class DigitalIdScreen extends StatelessWidget {
  const DigitalIdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 🔹 Placeholder values (can be replaced with dynamic data)
    const String fullName = "John Doe";
    const String studentId = "2023CS1234";
    const String university = "Ethiopian National University";
    const String department = "Computer Science";
    const String photoUrl =
        "https://www.w3schools.com/howto/img_avatar.png"; // Sample avatar image

    return Scaffold(
      appBar: AppBar(
        title: const Text("Digital Student ID"),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          margin: const EdgeInsets.all(20),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 🧑‍🎓 Student Photo
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(photoUrl),
                ),
                const SizedBox(height: 16),

                // 🔤 Full Name
                Text(
                  fullName,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),

                // 🎓 University
                Text(
                  university,
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 12),

                // 🆔 ID and Department
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("ID: $studentId", style: const TextStyle(fontSize: 16)),
                    Text(department, style: const TextStyle(fontSize: 16)),
                  ],
                ),
                const SizedBox(height: 20),

                // 🔳 Placeholder QR Code section
                Container(
                  height: 80,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    "QR Code Placeholder",
                    style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
