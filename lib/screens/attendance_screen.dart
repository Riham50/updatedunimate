import 'package:flutter/material.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data (replace with real DB data later)
    final List<Map<String, dynamic>> attendanceHistory = [
      {"course": "Mobile App Dev", "date": "June 1", "status": "Present"},
      {"course": "AI", "date": "May 30", "status": "Absent"},
      {"course": "Data Science", "date": "May 28", "status": "Present"},
    ];

    String todayStatus = "Not Marked"; // Could be "Present" or "Absent"

    return Scaffold(
      appBar: AppBar(title: const Text("Attendance")),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Navigate to QR scan screen or handle scanning
        },
        icon: const Icon(Icons.qr_code_scanner),
        label: const Text("Scan QR"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 📅 Today's status
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(Icons.today, color: Colors.blue),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Today's Attendance", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(todayStatus,
                      style: TextStyle(
                        color: todayStatus == "Present"
                            ? Colors.green
                            : todayStatus == "Absent"
                                ? Colors.red
                                : Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text("History", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          ),
          const SizedBox(height: 8),

          // 📊 Attendance History
          Expanded(
            child: ListView.builder(
              itemCount: attendanceHistory.length,
              itemBuilder: (context, index) {
                final entry = attendanceHistory[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: entry["status"] == "Present" ? Colors.green : Colors.red,
                    child: Icon(entry["status"] == "Present" ? Icons.check : Icons.close, color: Colors.white),
                  ),
                  title: Text(entry["course"]),
                  subtitle: Text("Date: ${entry["date"]}"),
                  trailing: Text(entry["status"],
                    style: TextStyle(
                      color: entry["status"] == "Present" ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
