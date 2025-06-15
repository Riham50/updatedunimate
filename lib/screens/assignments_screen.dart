import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/assignment_model.dart';
import '../services/assignment_service.dart';

class AssignmentScreen extends StatefulWidget {
  const AssignmentScreen({super.key});

  @override
  State<AssignmentScreen> createState() => _AssignmentScreenState();
}

class _AssignmentScreenState extends State<AssignmentScreen> {
  final AssignmentService _service = AssignmentService();
  String _searchText = "";

  void _showAddAssignmentForm({Assignment? assignment}) {
    final _formKey = GlobalKey<FormState>();
    final titleController = TextEditingController(text: assignment?.title ?? "");
    final courseController = TextEditingController(text: assignment?.course ?? "");
    DateTime? selectedDate = assignment?.dueDate;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 16,
                right: 16,
                top: 24,
              ),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        assignment == null ? "Add Assignment" : "Edit Assignment",
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),

                      TextFormField(
                        controller: titleController,
                        decoration: const InputDecoration(labelText: "Title"),
                        validator: (val) => val == null || val.isEmpty ? "Required" : null,
                      ),

                      const SizedBox(height: 8),
                      TextFormField(
                        controller: courseController,
                        decoration: const InputDecoration(labelText: "Course"),
                        validator: (val) => val == null || val.isEmpty ? "Required" : null,
                      ),

                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              selectedDate == null
                                  ? "Select due date"
                                  : "Due: ${DateFormat.yMMMd().format(selectedDate!)}",
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              DateTime now = DateTime.now();
                              final picked = await showDatePicker(
                                context: context,
                                initialDate: selectedDate ?? now,
                                firstDate: now,
                                lastDate: DateTime(now.year + 5),
                              );
                              if (picked != null) {
                                setModalState(() {
                                  selectedDate = picked;
                                });
                              }
                            },
                            child: const Text("Pick Date"),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate() && selectedDate != null) {
                            final newAssignment = Assignment(
                              id: assignment?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
                              title: titleController.text.trim(),
                              course: courseController.text.trim(),
                              dueDate: selectedDate!,
                              isCompleted: assignment?.isCompleted ?? false,
                            );

                            if (assignment == null) {
                              await _service.addAssignment(newAssignment);
                            } else {
                              await _service.updateAssignment(newAssignment);
                            }

                            Navigator.of(context).pop();
                          }
                        },
                        child: Text(assignment == null ? "Add" : "Update"),
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Assignments")),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddAssignmentForm(),
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                labelText: "Search by title or course",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _searchText = value.toLowerCase();
                });
              },
            ),
          ),

          Expanded(
            child: StreamBuilder<List<Assignment>>(
              stream: _service.getAssignmentStream(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

                List<Assignment> assignments = snapshot.data!;

                assignments = assignments
                    .where((a) =>
                        a.title.toLowerCase().contains(_searchText) ||
                        a.course.toLowerCase().contains(_searchText))
                    .toList();

                assignments.sort((a, b) => a.dueDate.compareTo(b.dueDate));

                if (assignments.isEmpty) {
                  return const Center(child: Text("No assignments found."));
                }

                return ListView.builder(
                  itemCount: assignments.length,
                  itemBuilder: (context, index) {
                    final a = assignments[index];
                    return Card(
                      child: ListTile(
                        title: Text(a.title),
                        subtitle: Text(
                          "${a.course} • Due: ${DateFormat.yMMMd().format(a.dueDate)}",
                        ),
                        trailing: Row(
  mainAxisSize: MainAxisSize.min,
  children: [
    Text(
      a.isCompleted ? "Completed" : "In Progress",
      style: TextStyle(
        color: a.isCompleted ? Colors.green : Colors.blue,
        fontWeight: FontWeight.w500,
      ),
    ),
    const SizedBox(width: 8),
   
    PopupMenuButton<String>(
  onSelected: (value) async {
    if (value == 'done' && !a.isCompleted) {
      await _service.updateAssignment(
        Assignment(
          id: a.id,
          title: a.title,
          course: a.course,
          dueDate: a.dueDate,
          isCompleted: true,
        ),
      );
    } else if (value == 'edit') {
      _showAddAssignmentForm(assignment: a);
    } else if (value == 'delete') {
      final confirm = await showDialog<bool>(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Delete Assignment"),
          content: const Text("Are you sure you want to delete this assignment?"),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("Cancel")),
            TextButton(onPressed: () => Navigator.pop(context, true), child: const Text("Delete")),
          ],
        ),
      );
      if (confirm == true) {
        await _service.deleteAssignment(a.id);
      }
    }
  },
  itemBuilder: (context) => [
    if (!a.isCompleted)
      const PopupMenuItem<String>(
        value: 'done',
        child: Text("Mark as Done"),
      ),
    const PopupMenuItem<String>(
      value: 'edit',
      child: Text("Edit"),
    ),
    const PopupMenuItem<String>(
      value: 'delete',
      child: Text("Delete"),
    ),
  ],
),

  ],
),

                          ),
                      
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
