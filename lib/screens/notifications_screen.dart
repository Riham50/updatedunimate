import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<Map<String, dynamic>> notifications = [
    {
      "title": "Assignment Due",
      "message": "Your AI assignment is due tomorrow. Make sure to submit it on time.",
      "timestamp": DateTime.now().subtract(const Duration(hours: 2)),
      "read": false,
    },
    {
      "title": "New Course Material",
      "message": "Mobile App Development lecture slides have been uploaded.",
      "timestamp": DateTime.now().subtract(const Duration(days: 1)),
      "read": true,
    },
    {
      "title": "Event: Hackathon",
      "message": "Register for the university Hackathon this weekend and win exciting prizes!",
      "timestamp": DateTime.now().subtract(const Duration(days: 3)),
      "read": false,
    },
  ];

  void _openNotification(int index) {
    setState(() {
      notifications[index]["read"] = true;
    });

    final n = notifications[index];

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(n["title"]),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(n["message"]),
            const SizedBox(height: 12),
            Text(
              DateFormat.yMMMd().add_jm().format(n["timestamp"]),
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Notifications")),
      body: notifications.isEmpty
          ? const Center(child: Text("No notifications"))
          : ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final n = notifications[index];
                final isUnread = !n["read"];
                final formattedTime = DateFormat.yMMMd().add_jm().format(n["timestamp"]);

                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: ListTile(
                    onTap: () => _openNotification(index),
                    leading: Stack(
                      children: [
                        const Icon(Icons.notifications, size: 30),
                        if (isUnread)
                          const Positioned(
                            top: 0,
                            right: 0,
                            child: CircleAvatar(
                              radius: 5,
                              backgroundColor: Colors.red,
                            ),
                          ),
                      ],
                    ),
                    title: Text(
                      n["title"],
                      style: TextStyle(
                        fontWeight: isUnread ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    subtitle: Text(
                      "${n["message"]}\n$formattedTime",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    isThreeLine: true,
                  ),
                );
              },
            ),
    );
  }
}
