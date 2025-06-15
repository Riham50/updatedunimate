// class CourseMaterial {
//   final String id;
//   final String title;
//   final String description;
//   final List<String> pdfUrls;

//   CourseMaterial({
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.pdfUrls,
//   });

//   factory CourseMaterial.fromMap(Map<String, dynamic> data, String docId) {
//     return CourseMaterial(
//       id: docId,
//       title: data['title'] ?? '',
//       description: data['description'] ?? '',
//       pdfUrls: List<String>.from(data['pdfUrls'] ?? []),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';

class CourseMaterial {
  final String id;
  final String title;
  final String description;
  final List<String> pdfUrls;

  CourseMaterial({
    required this.id,
    required this.title,
    required this.description,
    required this.pdfUrls,
  });

  factory CourseMaterial.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return CourseMaterial(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      pdfUrls: List<String>.from(data['pdfUrls'] ?? []),
    );
  }
}
