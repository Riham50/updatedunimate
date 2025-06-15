import 'package:flutter/material.dart';
import '../models/assignment_model.dart';
import 'package:intl/intl.dart';

class AssignmentCard extends StatelessWidget {
  final Assignment assignment;
  final VoidCallback onDelete;
  final VoidCallback onToggleComplete;

  const AssignmentCard({
    super.key,
    required this.assignment,
    required this.onDelete,
    required this.onToggleComplete,
  });

  @override
  Widget build(BuildContext context) {
    final isOverdue = !assignment.isCompleted && assignment.dueDate.isBefore(DateTime.now());

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: ListTile(
        leading: Icon(
          assignment.isCompleted
              ? Icons.check_circle
              : isOverdue
                  ? Icons.warning
                  : Icons.assignment,
          color: assignment.isCompleted
              ? Colors.green
              : isOverdue
                  ? Colors.red
                  : Colors.blue,
        ),
        title: Text(assignment.title),
        subtitle: Text(
          'Course: ${assignment.course}\nDue: ${DateFormat.yMMMd().format(assignment.dueDate)}',
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'complete') onToggleComplete();
            if (value == 'delete') onDelete();
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'complete',
              child: Text(assignment.isCompleted ? 'Mark Incomplete' : 'Mark Complete'),
            ),
            const PopupMenuItem(
              value: 'delete',
              child: Text('Delete'),
            ),
          ],
        ),
      ),
    );
  }
}
