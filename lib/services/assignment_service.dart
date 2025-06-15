// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../models/assignment_model.dart';

// class AssignmentService {
//   final CollectionReference _assignmentCollection =
//       FirebaseFirestore.instance.collection('assignments');

//   Stream<List<Assignment>> getAssignmentsStream() {
//     return _assignmentCollection.snapshots().map((snapshot) {
//       return snapshot.docs
//           .map((doc) => Assignment.fromMap(doc.id, doc.data() as Map<String, dynamic>))
//           .toList();
//     });
//   }

//   Future<void> addAssignment(Assignment assignment) async {
//     await _assignmentCollection.doc(assignment.id).set(assignment.toMap());
//   }

//   Future<void> updateAssignment(Assignment assignment) async {
//     await _assignmentCollection.doc(assignment.id).update(assignment.toMap());
//   }

//   Future<void> deleteAssignment(String id) async {
//     await _assignmentCollection.doc(id).delete();
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/assignment_model.dart';

class AssignmentService {
  final _db = FirebaseFirestore.instance.collection("assignments");

  Stream<List<Assignment>> getAssignmentStream() {
    return _db.snapshots().map((snapshot) =>
      snapshot.docs.map((doc) => Assignment.fromMap(doc.id, doc.data())).toList()
    );
  }

  Future<void> addAssignment(Assignment a) async {
    await _db.doc(a.id).set(a.toMap());
  }

  Future<void> updateAssignment(Assignment a) async {
    await _db.doc(a.id).update(a.toMap());
  }

  Future<void> deleteAssignment(String id) async {
    await _db.doc(id).delete();
  }
}

