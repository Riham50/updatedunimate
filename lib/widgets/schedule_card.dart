import 'package:flutter/material.dart';
import '../models/schedule_model.dart';

class ScheduleCard extends StatelessWidget {
  final ScheduleItem item;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final bool highlight;

  const ScheduleCard({
    required this.item,
    required this.onEdit,
    required this.onDelete,
    this.highlight = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: highlight ? Colors.yellow[100] : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            blurRadius: 6,
            color: Colors.black12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        title: Text(item.courseName, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('Instructor: ${item.instructor} - ${item.period}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(onPressed: onEdit, icon: const Icon(Icons.edit, color: Colors.blue)),
            IconButton(onPressed: onDelete, icon: const Icon(Icons.delete, color: Colors.red)),
          ],
        ),
      ),
    );
  }
}
