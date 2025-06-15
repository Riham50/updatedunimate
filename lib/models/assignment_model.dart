import 'package:cloud_firestore/cloud_firestore.dart';


// class Assignment {
//   final String id;
//   final String title;
//   final String course;
//   final DateTime dueDate;
//   final bool isCompleted;

//   Assignment({
//     required this.id,
//     required this.title,
//     required this.course,
//     required this.dueDate,
//     this.isCompleted = false,
//   });

//   factory Assignment.fromMap(String id, Map<String, dynamic> data) {
//     return Assignment(
//       id: id,
//       title: data['title'],
//       course: data['course'],
//       dueDate: (data['dueDate'] as Timestamp).toDate(),
//       isCompleted: data['isCompleted'],
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'title': title,
//       'course': course,
//       'dueDate': dueDate,
//       'isCompleted': isCompleted,
//     };
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';

class Assignment {
  final String id;
  final String title;
  final String course;
  final DateTime dueDate;
  final bool isCompleted;

  Assignment({
    required this.id,
    required this.title,
    required this.course,
    required this.dueDate,
    required this.isCompleted,
  });

  factory Assignment.fromMap(String id, Map<String, dynamic> data) {
    return Assignment(
      id: id,
      title: data['title'],
      course: data['course'],
      dueDate: (data['dueDate'] as Timestamp).toDate(),
      isCompleted: data['isCompleted'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'course': course,
      'dueDate': dueDate,
      'isCompleted': isCompleted,
    };
  }
}
